import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../mixins/validation_mixin.dart';
import '../widgets/app_components.dart';
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
          final screenHeight = constraints.maxHeight;
          
          const baseWidth = 1280.0;
          const baseHeight = 400.0;
          
          if (screenWidth < baseWidth || screenHeight < baseHeight) {
            return _buildScrollableLayout(baseWidth, baseHeight);
          } else {
            return _buildFixedLayout(baseWidth, baseHeight);
          }
        },
      ),
    );
  }

  Widget _buildScrollableLayout(double baseWidth, double baseHeight) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          width: baseWidth,
          height: baseHeight,
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

  Widget _buildFixedLayout(double baseWidth, double baseHeight) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Row(
        children: [
          Expanded(flex: 520, child: _buildLeftPanel()),
          Expanded(flex: 1000, child: _buildRightPanel()),
        ],
      ),
    );
  }

  Widget _buildLeftPanel() {
    return Container(
      height: double.infinity,
      color: AppConstants.primaryBackground,
      child: Stack(
        children: [
          Positioned(right: 60, top: 80, child: _buildBackButton()),
          Positioned(left: 60, top: 80, child: _buildLogoAndTitle()),
          Positioned(left: 60, top: 200, child: _buildForm()),
          Positioned(left: 60, top: 540, child: _buildContinueButton()),
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
    return const custom.AppLogo(
      width: 109.09,
      height: 40,
    );
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
    return AppEmailField(
      controller: _emailController,
      hintText: 'Digite seu e-mail',
      onChanged: (value) {
        setState(() {
          _isEmailValid = validateEmail(value) == null;
        });
      },
    );
  }

  Widget _buildNameField() {
    return AppNameField(
      controller: _usuarioController,
      hintText: 'Digite seu nome de usuário',
      onChanged: (value) {
        setState(() {
          _isUsuarioValid = validateRequired(value, 'Nome de usuário') == null;
        });
      },
    );
  }

  Widget _buildPasswordField() {
    return AppPasswordField(
      controller: _senhaController,
      hintText: 'Digite sua senha',
      onChanged: (value) {
        setState(() {
          _isSenhaValid = validatePassword(value) == null;
        });
      },
    );
  }

  Widget _buildCpfField() {
    return AppCpfField(
      controller: _cpfController,
      hintText: 'Digite seu CPF',
      onChanged: (value) {
        setState(() {
          _isCpfValid = validateCPF(value) == null;
        });
      },
      formatter: formatCPF,
    );
  }

  Widget _buildDateField() {
    return AppDateField(
      controller: _dataController,
      hintText: 'Digite sua data de nascimento',
      onChanged: (value) {
        setState(() {
          _isDataValid = validateDate(value) == null;
        });
      },
      formatter: formatDate,
    );
  }

  Widget _buildCheckboxes() {
    return SizedBox(
      width: 350,
      child: Column(
        children: [
          _buildCheckbox(
            value: _aceitaTermos,
            onChanged: (value) => setState(() => _aceitaTermos = value ?? false),
            text: 'Concordo com os Termos de Serviços e a Política de Privacidade',
          ),
          _buildCheckbox(
            value: _maiorIdade,
            onChanged: (value) => setState(() => _maiorIdade = value ?? false),
            text: 'Eu declaro ter 18 anos ou mais',
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
    return AppCheckbox(
      value: value,
      onChanged: onChanged,
      text: text,
      termsLink: termsLink,
      width: 300,
    );
  }

}