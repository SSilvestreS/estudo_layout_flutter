import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../widgets/app_components.dart';
import '../widgets/app_header.dart';
import '../widgets/video_panel.dart';
import '../mixins/validation_mixin.dart';
import 'email_login_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidationMixin {
  final _emailController = TextEditingController();
  bool _isEmailValid = false;

  @override
  void dispose() {
    _emailController.dispose();
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
        const AppHeader(),
        const SizedBox(height: 40),
        _buildEmailField(),
        const SizedBox(height: 20),
        _buildContinueButton(),
        const SizedBox(height: 30),
        _buildDivider(),
        const SizedBox(height: 30),
        _buildSocialButtons(),
        const SizedBox(height: 30),
        _buildCreateAccountLink(),
      ],
    );
  }

  Widget _buildLeftPanel() {
    return Container(
      height: double.infinity,
      color: AppConstants.primaryBackground,
      child: Stack(
        children: [
          Positioned(left: 60, top: 100, child: const AppHeader()),
          Positioned(left: 60, top: 200, child: _buildEmailField()),
          Positioned(left: 60, top: 280, child: _buildContinueButton()),
          Positioned(left: 60, top: 350, child: _buildDivider()),
          Positioned(left: 60, top: 400, child: _buildSocialButtons()),
          Positioned(left: 60, top: 500, child: _buildCreateAccountLink()),
        ],
      ),
    );
  }

  Widget _buildRightPanel() {
    return VideoPanel(
      socialIcons: _getSocialIcons(),
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

  Widget _buildContinueButton() {
    return AppButton(
      text: 'CONTINUAR',
      onPressed: _isEmailValid ? _handleContinue : null,
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.3),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'ou',
            style: TextStyle(
              color: AppConstants.textLightGray,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.3),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButtons() {
    return Column(
      children: [
        SocialButton(
          icon: Icons.login,
          label: 'Entrar com Google',
          onTap: () => _showMessage('Google em desenvolvimento'),
        ),
        const SizedBox(height: 12),
        SocialButton(
          icon: Icons.gamepad,
          label: 'Entrar com Discord',
          onTap: () => _showMessage('Discord em desenvolvimento'),
        ),
      ],
    );
  }

  Widget _buildCreateAccountLink() {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterScreen()),
        );
      },
      child: const Text(
        'Criar conta',
        style: TextStyle(
          color: AppConstants.textWhite,
          fontSize: 16,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  List<SocialIconData> _getSocialIcons() {
    return [
      const SocialIconData(
        icon: Icons.camera_alt,
        message: 'Instagram em desenvolvimento',
      ),
      const SocialIconData(
        imagePath: AppConstants.discordIconPath,
        fallbackIcon: Icons.gamepad,
        message: 'Discord em desenvolvimento',
      ),
      const SocialIconData(
        icon: Icons.close,
        message: 'X (Twitter) em desenvolvimento',
      ),
      const SocialIconData(
        icon: Icons.play_circle,
        message: 'Twitch em desenvolvimento',
      ),
      const SocialIconData(
        icon: Icons.play_arrow,
        message: 'YouTube em desenvolvimento',
      ),
    ];
  }

  void _handleContinue() {
    final email = _emailController.text.trim();
    if (validateEmail(email) == null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmailLoginScreen(email: email),
        ),
      );
    } else {
      showError(context, 'Email inválido');
    }
  }

  void _showMessage(String message) {
    showSuccess(context, message);
  }
}