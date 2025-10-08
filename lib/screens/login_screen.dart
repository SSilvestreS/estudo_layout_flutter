import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../mixins/validation_mixin.dart';
import '../widgets/video_panel.dart';
import '../widgets/social_button.dart';
import '../widgets/action_button.dart' as custom;
import 'email_login_screen.dart';

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
        _buildLogoAndTitle(),
        const SizedBox(height: 40),
        _buildEmailField(),
        const SizedBox(height: 20),
        _buildContinueButton(),
        const SizedBox(height: 30),
        _buildDivider(),
        const SizedBox(height: 30),
        _buildGoogleButton(),
        const SizedBox(height: 15),
        _buildDiscordButton(),
      ],
    );
  }

  Widget _buildLeftPanel() {
    return Container(
      height: double.infinity,
      color: AppConstants.primaryBackground,
      child: Stack(
        children: [
          Positioned(left: 60, top: 140, child: _buildLogoAndTitle()),
          Positioned(left: 78, top: 285, child: _buildEmailLabel()),
          Positioned(left: 60, top: 320, child: _buildEmailField()),
          Positioned(left: 60, top: 390, child: _buildContinueButton()),
          Positioned(left: 60, top: 510, child: _buildDivider()),
          Positioned(left: 60, top: 540, child: _buildGoogleButton()),
          Positioned(left: 60, top: 585, child: _buildDiscordButton()),
        ],
      ),
    );
  }

  Widget _buildRightPanel() {
    return VideoPanel(
      socialIcons: _getSocialIcons(),
    );
  }

  Widget _buildLogoAndTitle() {
    return const custom.AppLogo();
  }

  Widget _buildEmailLabel() {
    return const Text(
      'E-mail',
      style: TextStyle(
        color: AppConstants.textWhite,
        fontSize: 16,
      ),
    );
  }

  Widget _buildEmailField() {
    return Container(
      width: 380,
      height: 48, 
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
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintText: 'Digite seu e-mail',
          hintStyle: const TextStyle(
            color: AppConstants.textLightGray,
            fontSize: 14,
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

  Widget _buildContinueButton() {
    return custom.ActionButton.continueButton(
      onPressed: _handleContinue,
      isValid: _isEmailValid,
    );
  }

  Widget _buildDivider() {
    return SizedBox(
      width: 300,
      child: const Text(
        '— Ou use uma das opções abaixo —',
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Color(0xFFA0A0A0),
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildGoogleButton() {
    return SocialButton.google(
      onPressed: () => _showMessage('Google em desenvolvimento'),
    );
  }

  Widget _buildDiscordButton() {
    return SocialButton.discord(
      onPressed: () => _showMessage('Discord em desenvolvimento'),
    );
  }

  List<SocialIconData> _getSocialIcons() {
    return SocialIconData.getDefaultSocialIcons();
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