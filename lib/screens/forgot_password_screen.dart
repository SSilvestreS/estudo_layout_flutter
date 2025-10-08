import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../mixins/validation_mixin.dart';
import '../widgets/app_header.dart';
import '../widgets/video_panel.dart';
import '../widgets/action_button.dart' as custom;
import '../widgets/social_button.dart';

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
          Positioned(left: 60, top: 80, child: _buildLogoOnly()),
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
    return const custom.BackButton();
  }

  Widget _buildLogoOnly() {
    return const custom.AppLogo(
      width: 109.09,
      height: 40,
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
    return Container(
      width: 380,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          setState(() {
            _isEmailValid = validateEmail(value) == null;
          });
        },
        style: const TextStyle(
          color: AppConstants.textWhite,
          fontSize: 14,
        ),
        decoration: const InputDecoration(
          hintText: 'Digite seu e-mail',
          hintStyle: TextStyle(
            color: AppConstants.textLightGray,
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.email,
            color: AppConstants.accentGreen,
            size: 24,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
        ),
      ),
    );
  }

  Widget _buildSendButton() {
    return custom.ActionButton.sendButton(
      onPressed: _handleSend,
      isValid: _isEmailValid,
    );
  }

  List<SocialIconData> _getSocialIcons() {
    return SocialIconData.getDefaultSocialIcons();
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