import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import 'action_button.dart' as custom;

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
        Image.asset(
          AppConstants.logoPath,
          height: AppConstants.logoHeight,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppConstants.accentGreen,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'GB',
                      style: TextStyle(
                        color: AppConstants.primaryBackground,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  AppConstants.appTitle,
                  style: TextStyle(
                    color: AppConstants.textWhite,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          },
        ),
        if (showBackButton)
          _buildBackButton(context),
      ],
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return custom.BackButton(
      onPressed: onBackPressed ?? () => Navigator.pop(context),
    );
  }
}
