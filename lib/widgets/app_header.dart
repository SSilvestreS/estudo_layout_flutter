import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Componente reutilizável para o header com logo
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
        // Logo
        Image.asset(
          AppConstants.logoPath,
          height: AppConstants.logoHeight,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            // Fallback caso a imagem não carregue
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
        // Botão voltar (se necessário)
        if (showBackButton)
          _buildBackButton(context),
      ],
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: onBackPressed ?? () => Navigator.pop(context),
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
}
