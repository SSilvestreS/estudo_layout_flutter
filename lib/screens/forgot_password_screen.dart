import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../mixins/validation_mixin.dart';
import '../widgets/app_components.dart';
import '../widgets/app_header.dart';
import '../widgets/video_panel.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> with ValidationMixin {
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
        const AppHeader(showBackButton: true),
        const SizedBox(height: 40),
        _buildTitle(),
        const SizedBox(height: 40),
        _buildEmailField(),
        const SizedBox(height: 20),
        _buildSendButton(),
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
          Positioned(left: 60, top: 140, child: _buildLogoOnly()),
          Positioned(left: 60, top: 250, child: _buildTitle()),
          Positioned(left: 60, top: 320, child: _buildEmailField()),
          Positioned(left: 60, top: 390, child: _buildSendButton()),
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
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_back_ios, color: AppConstants.textWhite, size: 16),
            SizedBox(width: 6),
            Text(
              'voltar',
              style: TextStyle(color: AppConstants.textWhite, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoOnly() {
    return SizedBox(
      width: 260,
      height: 65,
      child: Image.asset(
        'assets/images/logo_gamersbrawl.png',
        height: 65,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: AppConstants.accentGreen,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'GB',
                style: TextStyle(
                  color: AppConstants.primaryBackground,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Esqueci minha senha',
      style: TextStyle(
        color: AppConstants.textWhite,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
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

  Widget _buildSendButton() {
    return AppButton(
      text: 'ENVIAR',
      onPressed: _isEmailValid ? _handleSend : null,
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

  void _handleSend() {
    final email = _emailController.text.trim();
    if (validateEmail(email) == null) {
      showSuccess(context, 'Instruções enviadas para $email');
    } else {
      showError(context, 'Email inválido');
    }
  }
}