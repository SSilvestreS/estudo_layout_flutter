import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../mixins/validation_mixin.dart';
import '../widgets/app_components.dart';
import '../widgets/app_header.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with ValidationMixin {
  bool _aceitaTermos = false;
  bool _maiorIdade = false;
  final _emailController = TextEditingController();
  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();
  final _cpfController = TextEditingController();
  final _dataController = TextEditingController();

  // Estados de validação
  bool _isEmailValid = false;
  bool _isUsuarioValid = false;
  bool _isSenhaValid = false;
  bool _isCpfValid = false;
  bool _isDataValid = false;

  @override
  void dispose() {
    _emailController.dispose();
    _usuarioController.dispose();
    _senhaController.dispose();
    _cpfController.dispose();
    _dataController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.primaryBackground,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  minWidth: constraints.maxWidth,
                ),
                child: IntrinsicHeight(
                  child: Container(
                    color: AppConstants.primaryBackground,
                    padding: AppConstants.defaultPadding,
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AppHeader(showBackButton: true),
                            const SizedBox(height: 60),
                            _buildTitle(),
                            const SizedBox(height: 40),
                            _buildForm(),
                            const SizedBox(height: 30),
                            _buildCheckboxes(),
                            const SizedBox(height: 30),
                            _buildRegisterButton(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Criar Conta',
      style: TextStyle(
        color: AppConstants.textWhite,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        _buildEmailField(),
        const SizedBox(height: 20),
        _buildNameField(),
        const SizedBox(height: 20),
        _buildPasswordField(),
        const SizedBox(height: 20),
        _buildCpfField(),
        const SizedBox(height: 20),
        _buildDateField(),
      ],
    );
  }

  Widget _buildEmailField() {
    return SizedBox(
      width: 300,
      child: AppTextField(
        controller: _emailController,
        hintText: 'Digite seu e-mail',
        prefixIcon: Icons.email,
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          setState(() {
            _isEmailValid = validateEmail(value) == null;
          });
        },
      ),
    );
  }

  Widget _buildNameField() {
    return SizedBox(
      width: 300,
      child: AppTextField(
        controller: _usuarioController,
        hintText: 'Digite seu nome de usuário',
        prefixIcon: Icons.person,
        onChanged: (value) {
          setState(() {
            _isUsuarioValid = validateRequired(value, 'Nome de usuário') == null;
          });
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return SizedBox(
      width: 300,
      child: AppTextField(
        controller: _senhaController,
        hintText: 'Digite sua senha',
        prefixIcon: Icons.lock,
        obscureText: true,
        onChanged: (value) {
          setState(() {
            _isSenhaValid = validatePassword(value) == null;
          });
        },
      ),
    );
  }

  Widget _buildCpfField() {
    return SizedBox(
      width: 300,
      child: AppTextField(
        controller: _cpfController,
        hintText: 'Digite seu CPF',
        prefixIcon: Icons.badge,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          setState(() {
            _isCpfValid = validateCPF(value) == null;
          });
          // Aplicar formatação
          final formatted = formatCPF(value);
          if (formatted != value) {
            _cpfController.value = TextEditingValue(
              text: formatted,
              selection: TextSelection.collapsed(offset: formatted.length),
            );
          }
        },
      ),
    );
  }

  Widget _buildDateField() {
    return SizedBox(
      width: 300,
      child: AppTextField(
        controller: _dataController,
        hintText: 'Digite sua data de nascimento',
        prefixIcon: Icons.calendar_today,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          setState(() {
            _isDataValid = validateDate(value) == null;
          });
          // Aplicar formatação
          final formatted = formatDate(value);
          if (formatted != value) {
            _dataController.value = TextEditingValue(
              text: formatted,
              selection: TextSelection.collapsed(offset: formatted.length),
            );
          }
        },
      ),
    );
  }

  Widget _buildCheckboxes() {
    return Column(
      children: [
        _buildCheckbox(
          value: _aceitaTermos,
          onChanged: (value) => setState(() => _aceitaTermos = value ?? false),
          text: 'Aceito os termos de uso',
        ),
        const SizedBox(height: 16),
        _buildCheckbox(
          value: _maiorIdade,
          onChanged: (value) => setState(() => _maiorIdade = value ?? false),
          text: 'Confirmo que sou maior de idade',
        ),
      ],
    );
  }

  Widget _buildCheckbox({
    required bool value,
    required ValueChanged<bool?> onChanged,
    required String text,
  }) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: AppConstants.accentGreen,
          checkColor: AppConstants.primaryBackground,
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: AppConstants.textWhite,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    final isFormValid = _isEmailValid &&
        _isUsuarioValid &&
        _isSenhaValid &&
        _isCpfValid &&
        _isDataValid &&
        _aceitaTermos &&
        _maiorIdade;

    return AppButton(
      text: 'CADASTRAR',
      onPressed: isFormValid ? _handleRegister : null,
    );
  }

  void _handleRegister() {
    if (_validateAllFields()) {
      showSuccess(context, 'Cadastro realizado com sucesso!');
      Navigator.pop(context);
    } else {
      showError(context, 'Preencha todos os campos obrigatórios');
    }
  }

  bool _validateAllFields() {
    return _isEmailValid &&
        _isUsuarioValid &&
        _isSenhaValid &&
        _isCpfValid &&
        _isDataValid &&
        _aceitaTermos &&
        _maiorIdade;
  }
}