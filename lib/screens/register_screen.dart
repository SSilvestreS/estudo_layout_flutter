import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../mixins/validation_mixin.dart';
import '../widgets/action_button.dart' as custom;
import '../widgets/social_button.dart';
import '../widgets/video_panel.dart';

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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          
          if (screenWidth < 1200) {
            return _buildResponsiveLayout();
          } else {
            return _buildFixedLayout();
          }
        },
      ),
    );
  }

  Widget _buildResponsiveLayout() {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: AppConstants.defaultPadding,
              child: _buildLeftPanelContent(),
            ),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              child: _buildRightPanel(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFixedLayout() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Row(
            children: [
              Expanded(flex: 520, child: _buildLeftPanel()),
              Expanded(flex: 1000, child: _buildRightPanel()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeftPanelContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLogoAndTitle(),
        const SizedBox(height: 20),
        _buildForm(),
      ],
    );
  }

  Widget _buildLeftPanel() {
    return Container(
      height: double.infinity,
      color: AppConstants.primaryBackground,
      child: Stack(
        children: [
          Positioned(right: 60, top: 80, child: _buildBackButton()),
          Positioned(left: 60, top: 140, child: _buildLogoAndTitle()),
          Positioned(left: 60, top: 250, child: _buildForm()),
        ],
      ),
    );
  }

  Widget _buildRightPanel() {
    return VideoPanel(
      socialIcons: _getSocialIcons(),
    );
  }

  Widget _buildBackButton() {
    return const custom.BackButton();
  }

  Widget _buildLogoAndTitle() {
    return const custom.AppLogo();
  }

  List<SocialIconData> _getSocialIcons() {
    return SocialIconData.getDefaultSocialIcons();
  }

  Widget _buildForm() {
    return Column(
      children: [
        _buildEmailField(),
        const SizedBox(height: 8),
        _buildNameField(),
        const SizedBox(height: 8),
        _buildCpfField(),
        const SizedBox(height: 8),
        _buildDateField(),
        const SizedBox(height: 8),
        _buildPasswordField(),
        const SizedBox(height: 12),
        _buildCheckboxes(),
        const SizedBox(height: 12),
        _buildContinueButton(),
      ],
    );
  }

  Widget _buildContinueButton() {
    final isFormValid = _isEmailValid &&
        _isUsuarioValid &&
        _isSenhaValid &&
        _isCpfValid &&
        _isDataValid &&
        _aceitaTermos &&
        _maiorIdade;

    return custom.ActionButton.continueButton(
      onPressed: _handleContinue,
      isValid: isFormValid,
    );
  }

  void _handleContinue() {
    if (_isEmailValid && _isUsuarioValid && _isSenhaValid && _isCpfValid && _isDataValid && _aceitaTermos && _maiorIdade) {
      showSuccess(context, 'Cadastro realizado com sucesso!');
      Navigator.pop(context);
    }
  }

  Widget _buildEmailField() {
    return Container(
      width: 300,
      height: 55,
      decoration: BoxDecoration(
        color: AppConstants.inputBackground,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextFormField(
        controller: _emailController,
        onChanged: (value) {
          setState(() {
            _isEmailValid = validateEmail(value) == null;
          });
        },
        style: const TextStyle(
          color: AppConstants.textWhite,
          fontSize: 17,
        ),
        decoration: InputDecoration(
          hintText: 'Digite seu e-mail',
          hintStyle: const TextStyle(
            color: AppConstants.textLightGray,
            fontSize: 17,
          ),
          prefixIcon: const Icon(
            Icons.email,
            color: AppConstants.accentGreen,
            size: 24,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return Container(
      width: 300,
      height: 55,
      decoration: BoxDecoration(
        color: AppConstants.inputBackground,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextFormField(
        controller: _usuarioController,
        onChanged: (value) {
          setState(() {
            _isUsuarioValid = validateRequired(value, 'Nome de usuário') == null;
          });
        },
        style: const TextStyle(
          color: AppConstants.textWhite,
          fontSize: 17,
        ),
        decoration: InputDecoration(
          hintText: 'Digite seu nome de usuário',
          hintStyle: const TextStyle(
            color: AppConstants.textLightGray,
            fontSize: 17,
          ),
          prefixIcon: const Icon(
            Icons.person,
            color: AppConstants.accentGreen,
            size: 24,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      width: 300,
      height: 55,
      decoration: BoxDecoration(
        color: AppConstants.inputBackground,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextFormField(
        controller: _senhaController,
        obscureText: true,
        onChanged: (value) {
          setState(() {
            _isSenhaValid = validatePassword(value) == null;
          });
        },
        style: const TextStyle(
          color: AppConstants.textWhite,
          fontSize: 17,
        ),
        decoration: InputDecoration(
          hintText: 'Digite sua senha',
          hintStyle: const TextStyle(
            color: AppConstants.textLightGray,
            fontSize: 17,
          ),
          prefixIcon: const Icon(
            Icons.lock,
            color: AppConstants.accentGreen,
            size: 24,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15),
        ),
      ),
    );
  }

  Widget _buildCpfField() {
    return Container(
      width: 300,
      height: 55,
      decoration: BoxDecoration(
        color: AppConstants.inputBackground,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextFormField(
        controller: _cpfController,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          setState(() {
            _isCpfValid = validateCPF(value) == null;
          });
          final formatted = formatCPF(value);
          if (formatted != value) {
            _cpfController.value = TextEditingValue(
              text: formatted,
              selection: TextSelection.collapsed(offset: formatted.length),
            );
          }
        },
        style: const TextStyle(
          color: AppConstants.textWhite,
          fontSize: 17,
        ),
        decoration: InputDecoration(
          hintText: 'Digite seu CPF',
          hintStyle: const TextStyle(
            color: AppConstants.textLightGray,
            fontSize: 17,
          ),
          prefixIcon: const Icon(
            Icons.badge,
            color: AppConstants.accentGreen,
            size: 24,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15),
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return Container(
      width: 300,
      height: 55,
      decoration: BoxDecoration(
        color: AppConstants.inputBackground,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextFormField(
        controller: _dataController,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          setState(() {
            _isDataValid = validateDate(value) == null;
          });
          final formatted = formatDate(value);
          if (formatted != value) {
            _dataController.value = TextEditingValue(
              text: formatted,
              selection: TextSelection.collapsed(offset: formatted.length),
            );
          }
        },
        style: const TextStyle(
          color: AppConstants.textWhite,
          fontSize: 17,
        ),
        decoration: InputDecoration(
          hintText: 'Digite sua data de nascimento',
          hintStyle: const TextStyle(
            color: AppConstants.textLightGray,
            fontSize: 17,
          ),
          prefixIcon: const Icon(
            Icons.calendar_today,
            color: AppConstants.accentGreen,
            size: 24,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15),
        ),
      ),
    );
  }

  Widget _buildCheckboxes() {
    return SizedBox(
      width: 300,
      child: Column(
        children: [
          _buildCheckbox(
            value: _aceitaTermos,
            onChanged: (value) => setState(() => _aceitaTermos = value ?? false),
            text: 'Aceito os ',
            termsLink: true,
          ),
          const SizedBox(height: 6),
          _buildCheckbox(
            value: _maiorIdade,
            onChanged: (value) => setState(() => _maiorIdade = value ?? false),
            text: 'Confirmo que sou maior de idade',
          ),
        ],
      ),
    );
  }

  Widget _buildCheckbox({
    required bool value,
    required ValueChanged<bool?> onChanged,
    required String text,
    bool termsLink = false,
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
          child: termsLink 
            ? SizedBox(
                width: 250,
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: AppConstants.textWhite,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(text: text),
                      TextSpan(
                        text: 'termos de uso',
                        style: const TextStyle(
                          color: AppConstants.accentGreen,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Text(
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

}