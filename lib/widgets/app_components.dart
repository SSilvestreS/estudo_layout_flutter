import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Componente reutilizável para campos de entrada de texto
class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool enabled;

  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstants.inputHeight,
      decoration: BoxDecoration(
        color: AppConstants.inputBackground,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        onChanged: onChanged,
        enabled: enabled,
        style: const TextStyle(
          color: AppConstants.textWhite,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppConstants.textLightGray,
            fontSize: 16,
          ),
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: AppConstants.textLightGray,
                  size: AppConstants.iconSize,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}

/// Componente reutilizável para botões principais
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final Color? backgroundColor;
  final Color? textColor;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 180,
      height: AppConstants.buttonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppConstants.accentGreen,
          foregroundColor: textColor ?? AppConstants.primaryBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppConstants.primaryBackground),
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}

/// Componente reutilizável para botões sociais
class SocialButton extends StatelessWidget {
  final IconData? icon;
  final String? imagePath;
  final IconData? fallbackIcon;
  final String label;
  final VoidCallback onTap;
  final double height;

  const SocialButton({
    super.key,
    this.icon,
    this.imagePath,
    this.fallbackIcon,
    required this.label,
    required this.onTap,
    this.height = 28,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: height,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppConstants.textWhite,
          side: BorderSide(
            color: Colors.white.withValues(alpha: 0.3),
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imagePath != null)
              Image.asset(
                imagePath!,
                width: 16,
                height: 16,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Icon(
                  fallbackIcon ?? Icons.link,
                  color: AppConstants.textWhite,
                  size: 16,
                ),
              )
            else if (icon != null)
              Icon(icon, color: AppConstants.textWhite, size: 16),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Componente reutilizável para ícones sociais
class SocialIcon extends StatelessWidget {
  final IconData? icon;
  final String? imagePath;
  final IconData? fallbackIcon;
  final VoidCallback onTap;

  const SocialIcon({
    super.key,
    this.icon,
    this.imagePath,
    this.fallbackIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstants.socialIconSize,
      height: AppConstants.socialIconSize,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppConstants.socialIconSize / 2),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppConstants.socialIconSize / 2),
          onTap: onTap,
          child: Center(
            child: imagePath != null
                ? Image.asset(
                    imagePath!,
                    width: AppConstants.iconSize,
                    height: AppConstants.iconSize,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Icon(
                      fallbackIcon ?? Icons.link,
                      color: AppConstants.textWhite,
                      size: AppConstants.iconSize,
                    ),
                  )
                : Icon(
                    icon,
                    color: AppConstants.textWhite,
                    size: AppConstants.iconSize,
                  ),
          ),
        ),
      ),
    );
  }
}
