import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class AppEmailField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChanged;
  final bool enabled;
  final double? width;
  final double? height;

  const AppEmailField({
    super.key,
    required this.controller,
    this.hintText = 'Digite seu e-mail',
    this.onChanged,
    this.enabled = true,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 350,
      height: height ?? 40,
      decoration: BoxDecoration(
        color: AppConstants.inputBackground,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        keyboardType: TextInputType.emailAddress,
        onChanged: onChanged,
        style: const TextStyle(
          color: AppConstants.textWhite,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppConstants.textLightGray,
            fontSize: 15,
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
}

class AppNameField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChanged;
  final double? width;
  final double? height;

  const AppNameField({
    super.key,
    required this.controller,
    this.hintText = 'Digite seu nome de usuário',
    this.onChanged,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 350,
      height: height ?? 40,
      decoration: BoxDecoration(
        color: AppConstants.inputBackground,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(
          color: AppConstants.textWhite,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppConstants.textLightGray,
            fontSize: 15,
          ),
          prefixIcon: const Icon(
            Icons.person,
            color: AppConstants.accentGreen,
            size: 24,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15),
        ),
      ),
    );
  }
}

class AppCpfField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChanged;
  final String Function(String)? formatter;
  final double? width;
  final double? height;

  const AppCpfField({
    super.key,
    required this.controller,
    this.hintText = 'Digite seu CPF',
    this.onChanged,
    this.formatter,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 350,
      height: height ?? 40,
      decoration: BoxDecoration(
        color: AppConstants.inputBackground,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          onChanged?.call(value);
          if (formatter != null) {
            final formatted = formatter!(value);
            if (formatted != value) {
              controller.value = TextEditingValue(
                text: formatted,
                selection: TextSelection.collapsed(offset: formatted.length),
              );
            }
          }
        },
        style: const TextStyle(
          color: AppConstants.textWhite,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppConstants.textLightGray,
            fontSize: 15,
          ),
          prefixIcon: const Icon(
            Icons.badge,
            color: AppConstants.accentGreen,
            size: 24,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15),
        ),
      ),
    );
  }
}

class AppDateField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChanged;
  final String Function(String)? formatter;
  final double? width;
  final double? height;

  const AppDateField({
    super.key,
    required this.controller,
    this.hintText = 'Digite sua data de nascimento',
    this.onChanged,
    this.formatter,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 350,
      height: height ?? 40,
      decoration: BoxDecoration(
        color: AppConstants.inputBackground,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          onChanged?.call(value);
          if (formatter != null) {
            final formatted = formatter!(value);
            if (formatted != value) {
              controller.value = TextEditingValue(
                text: formatted,
                selection: TextSelection.collapsed(offset: formatted.length),
              );
            }
          }
        },
        style: const TextStyle(
          color: AppConstants.textWhite,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppConstants.textLightGray,
            fontSize: 15,
          ),
          prefixIcon: const Icon(
            Icons.calendar_today,
            color: AppConstants.accentGreen,
            size: 24,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15),
        ),
      ),
    );
  }
}

class AppPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChanged;
  final double? width;
  final double? height;

  const AppPasswordField({
    super.key,
    required this.controller,
    this.hintText = 'Digite sua senha',
    this.onChanged,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 350,
      height: height ?? 40,
      decoration: BoxDecoration(
        color: AppConstants.inputBackground,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: true,
        onChanged: onChanged,
        style: const TextStyle(
          color: AppConstants.textWhite,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppConstants.textLightGray,
            fontSize: 15,
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
}

class AppCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String text;
  final bool termsLink;
  final double? width;

  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.text,
    this.termsLink = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: AppConstants.accentGreen,
          checkColor: AppConstants.primaryBackground,
        ),
        Expanded(
          child: termsLink 
            ? SizedBox(
                width: width ?? 300,
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: AppConstants.textWhite,
                      fontSize: 10,
                    ),
                    children: [
                      TextSpan(text: text),
                      TextSpan(
                        text: 'termos de uso',
                        style: const TextStyle(
                          color: AppConstants.accentGreen,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  color: AppConstants.textWhite,
                  fontSize: 10,
                ),
              ),
        ),
      ],
    );
  }
}

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
                  color: AppConstants.accentGreen,
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

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 180,
      height: height ?? AppConstants.buttonHeight,
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
                style: TextStyle(
                  fontSize: fontSize ?? 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}

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
