import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import 'app_components.dart';

class AppHeader extends StatelessWidget {
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  const AppHeader({
    super.key,
    this.showBackButton = false,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppLogo(
          height: AppConstants.logoHeight,
        ),
        if (showBackButton)
          AppButton.backButton(
            onPressed: onBackPressed ?? () => Navigator.pop(context),
          ),
      ],
    );
  }
}
