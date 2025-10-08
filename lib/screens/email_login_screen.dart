import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../mixins/validation_mixin.dart';
import '../widgets/app_header.dart';
import '../widgets/video_panel.dart';
import '../widgets/action_button.dart' as custom;
import '../widgets/social_button.dart';
import 'forgot_password_screen.dart';

class EmailLoginScreen extends StatefulWidget {
  final String email;
  
  const EmailLoginScreen({super.key, required this.email});

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> with ValidationMixin {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _isPasswordValid = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.email);
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
        const AppHeader(showBackButton: true),
        const SizedBox(height: 40),
        _buildEmailField(),
        const SizedBox(height: 20),
        _buildPasswordField(),
        const SizedBox(height: 20),
        _buildForgotPasswordLink(),
        const SizedBox(height: 20),
        _buildLoginButton(),
      ],
    );
  }

  Widget _buildLeftPanel() {
    return Container(
      height: double.infinity,
      color: AppConstants.primaryBackground,
      child: Stack(
        children: [
          // Botão voltar - Lado direito da tela
          Positioned(right: 60, top: 80, child: _buildBackButton()),
          // Logo - Posição: x: 60 px, y: 140 px (mesmo que tela inicial)
          Positioned(left: 60, top: 140, child: _buildLogoOnly()),
          Positioned(left: 60, top: 320, child: _buildEmailField()),
          Positioned(left: 60, top: 390, child: _buildPasswordField()),
          Positioned(left: 60, top: 460, child: _buildForgotPasswordLink()),
          Positioned(left: 60, top: 500, child: _buildLoginButton()),
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

  Widget _buildLogoOnly() {
    return const custom.AppLogo();
  }

  Widget _buildEmailField() {
    return Container(
      width: 350,
      height: 55,
      decoration: BoxDecoration(
        color: AppConstants.inputBackground,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextFormField(
        controller: _emailController,
        enabled: false,
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

  Widget _buildPasswordField() {
    return Container(
      width: 350,
      height: 55,
      decoration: BoxDecoration(
        color: AppConstants.inputBackground,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextFormField(
        controller: _passwordController,
        obscureText: true,
        onChanged: (value) {
          setState(() {
            _isPasswordValid = validatePassword(value) == null;
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

  Widget _buildForgotPasswordLink() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
        );
      },
      child: const Text(
        'Esqueci minha senha',
        style: TextStyle(
          color: AppConstants.textWhite,
          fontSize: 14,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return custom.ActionButton.loginButton(
      onPressed: _handleLogin,
      isValid: _isPasswordValid,
    );
  }

  List<SocialIconData> _getSocialIcons() {
    return SocialIconData.getDefaultSocialIcons();
  }

  void _handleLogin() {
    final password = _passwordController.text.trim();
    if (validatePassword(password) == null) {
      _showMessage('Login realizado com sucesso!');
    } else {
      showError(context, 'Senha inválida');
    }
  }

  void _showMessage(String message) {
    showSuccess(context, message);
  }
}