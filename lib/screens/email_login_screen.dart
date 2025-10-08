import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../mixins/validation_mixin.dart';
import '../widgets/app_header.dart';
import '../widgets/app_components.dart';
import '../widgets/social_button.dart';
import '../widgets/video_panel.dart';
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
        const AppHeader(showBackButton: false),
        const SizedBox(height: 20),
        _buildBackButton(),
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
          Positioned(left: 60, top: 80, child: _buildLogoOnly()),
          Positioned(right: 60, top: 80, child: _buildBackButton()),
          Positioned(left: 78, top: 200, child: _buildEmailLabel()),
          Positioned(left: 60, top: 240, child: _buildEmailField()),
          Positioned(left: 60, top: 300, child: _buildPasswordField()),
          Positioned(left: 60, top: 360, child: _buildForgotPasswordLink()),
          Positioned(left: 60, top: 420, child: _buildLoginButton()),
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
    return AppButton.backButton(
      onPressed: () => Navigator.pop(context),
    );
  }

  Widget _buildLogoOnly() {
    return const AppLogo(
      width: 109.09,
      height: 40,
    );
  }

  Widget _buildEmailLabel() {
    return const Text(
      'Entrar com e-mail',
      style: TextStyle(
        color: AppConstants.textWhite,
        fontSize: 16,
      ),
    );
  }

  Widget _buildEmailField() {
    return SizedBox(
      width: 380,
      child: AppTextField(
        controller: _emailController,
        hintText: 'Digite seu e-mail',
        prefixIcon: Icons.email,
        enabled: false,
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Widget _buildPasswordField() {
    return SizedBox(
      width: 380,
      child: AppTextField(
        controller: _passwordController,
        hintText: 'Digite sua senha',
        prefixIcon: Icons.lock,
        obscureText: true,
        onChanged: (value) {
          setState(() {
            _isPasswordValid = validatePassword(value) == null;
          });
        },
      ),
    );
  }

  Widget _buildForgotPasswordLink() {
    return SizedBox(
      width: 180,
      child: AppButton(
        text: 'Esqueci minha senha',
        enabledColor: Colors.transparent,
        enabledTextColor: AppConstants.textWhite,
        fontSize: 12,
        height: 36,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
          );
        },
      ),
    );
  }

  Widget _buildLoginButton() {
    return AppButton.loginButton(
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