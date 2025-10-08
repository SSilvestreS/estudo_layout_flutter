import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class AppLogo extends StatelessWidget {
  final double width;
  final double height;
  final BoxFit fit;
  final String? logoPath;

  const AppLogo({
    super.key,
    this.width = 260,
    this.height = 65,
    this.fit = BoxFit.contain,
    this.logoPath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Image.asset(
        logoPath ?? AppConstants.logoPath,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: height * 0.85,
            height: height * 0.85,
            decoration: BoxDecoration(
              color: AppConstants.accentGreen,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                'GB',
                style: TextStyle(
                  color: AppConstants.primaryBackground,
                  fontSize: height * 0.3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


class AppField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChanged;
  final String Function(String)? formatter;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool enabled;
  final double? width;
  final double? height;

  const AppField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.formatter,
    this.prefixIcon = Icons.person,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.enabled = true,
    this.width,
    this.height,
  });

  // Factory constructor para campo de email
  factory AppField.email({
    Key? key,
    required TextEditingController controller,
    String hintText = 'Digite seu e-mail',
    void Function(String)? onChanged,
    bool enabled = true,
    double? width,
    double? height,
  }) {
    return AppField(
      key: key,
      controller: controller,
      hintText: hintText,
      onChanged: onChanged,
      enabled: enabled,
      prefixIcon: Icons.email,
      keyboardType: TextInputType.emailAddress,
      width: width,
      height: height,
    );
  }

  // Factory constructor para campo de nome
  factory AppField.name({
    Key? key,
    required TextEditingController controller,
    String hintText = 'Digite seu nome de usuário',
    void Function(String)? onChanged,
    double? width,
    double? height,
  }) {
    return AppField(
      key: key,
      controller: controller,
      hintText: hintText,
      onChanged: onChanged,
      prefixIcon: Icons.person,
      keyboardType: TextInputType.text,
      width: width,
      height: height,
    );
  }

  // Factory constructor para campo de CPF
  factory AppField.cpf({
    Key? key,
    required TextEditingController controller,
    String hintText = 'Digite seu CPF',
    void Function(String)? onChanged,
    String Function(String)? formatter,
    double? width,
    double? height,
  }) {
    return AppField(
      key: key,
      controller: controller,
      hintText: hintText,
      onChanged: onChanged,
      formatter: formatter,
      prefixIcon: Icons.badge,
      keyboardType: TextInputType.number,
      width: width,
      height: height,
    );
  }

  // Factory constructor para campo de data
  factory AppField.date({
    Key? key,
    required TextEditingController controller,
    String hintText = 'Digite sua data de nascimento',
    void Function(String)? onChanged,
    String Function(String)? formatter,
    double? width,
    double? height,
  }) {
    return AppField(
      key: key,
      controller: controller,
      hintText: hintText,
      onChanged: onChanged,
      formatter: formatter,
      prefixIcon: Icons.calendar_today,
      keyboardType: TextInputType.number,
      width: width,
      height: height,
    );
  }

  // Factory constructor para campo de senha
  factory AppField.password({
    Key? key,
    required TextEditingController controller,
    String hintText = 'Digite sua senha',
    void Function(String)? onChanged,
    double? width,
    double? height,
  }) {
    return AppField(
      key: key,
      controller: controller,
      hintText: hintText,
      onChanged: onChanged,
      prefixIcon: Icons.lock,
      keyboardType: TextInputType.text,
      obscureText: true,
      width: width,
      height: height,
    );
  }

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
        keyboardType: keyboardType,
        obscureText: obscureText,
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
          prefixIcon: Icon(
            prefixIcon,
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
  final bool isValid;
  final bool isLoading;
  final double? width;
  final double? height;
  final double? fontSize;
  final Color? enabledColor;
  final Color? disabledColor;
  final Color? enabledTextColor;
  final Color? disabledTextColor;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isValid = true,
    this.isLoading = false,
    this.width,
    this.height,
    this.fontSize,
    this.enabledColor,
    this.disabledColor,
    this.enabledTextColor,
    this.disabledTextColor,
  });

  // Factory constructor para botão de continuar
  factory AppButton.continueButton({
    required VoidCallback? onPressed,
    required bool isValid,
    double? width,
    double? height,
  }) {
    return AppButton(
      text: 'CONTINUAR',
      onPressed: onPressed,
      isValid: isValid,
      width: width,
      height: height,
    );
  }

  // Factory constructor para botão de entrar
  factory AppButton.loginButton({
    required VoidCallback? onPressed,
    required bool isValid,
    double? width,
    double? height,
  }) {
    return AppButton(
      text: 'ENTRAR',
      onPressed: onPressed,
      isValid: isValid,
      width: width,
      height: height,
    );
  }

  // Factory constructor para botão de enviar
  factory AppButton.sendButton({
    required VoidCallback? onPressed,
    required bool isValid,
    double? width,
    double? height,
  }) {
    return AppButton(
      text: 'ENVIAR',
      onPressed: onPressed,
      isValid: isValid,
      width: width,
      height: height,
    );
  }

  // Factory constructor para botão de cadastro
  factory AppButton.registerButton({
    required VoidCallback? onPressed,
    required bool isValid,
    double? width,
    double? height,
  }) {
    return AppButton(
      text: 'CADASTRAR',
      onPressed: onPressed,
      isValid: isValid,
      width: width,
      height: height,
    );
  }

  // Factory constructor para botão de voltar
  factory AppButton.backButton({
    required VoidCallback? onPressed,
    double? width,
    double? height,
  }) {
    return AppButton(
      text: 'voltar',
      onPressed: onPressed,
      isValid: true,
      width: width ?? 100,
      height: height ?? 40,
      fontSize: 14,
      enabledColor: Colors.transparent,
      enabledTextColor: AppConstants.textWhite,
    );
  }

  bool _isBackButton() {
    return text.toLowerCase() == 'voltar';
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = isValid && onPressed != null && !isLoading;
    final buttonWidth = width ?? 180;
    final buttonHeight = height ?? AppConstants.buttonHeight;
    
    // Se for botão de voltar, usar InkWell sem borda
    if (_isBackButton()) {
      return SizedBox(
        width: buttonWidth,
        height: buttonHeight,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: isEnabled ? onPressed : null,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: isEnabled 
                        ? (enabledTextColor ?? AppConstants.textWhite)
                        : (disabledTextColor ?? const Color(0xFF999999)),
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: fontSize ?? 14,
                      fontWeight: FontWeight.normal,
                      color: isEnabled 
                          ? (enabledTextColor ?? AppConstants.textWhite)
                          : (disabledTextColor ?? const Color(0xFF999999)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    
    // Botões normais com ElevatedButton
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled 
              ? (enabledColor ?? AppConstants.accentGreen)
              : (disabledColor ?? const Color(0xFF555555)),
          foregroundColor: isEnabled 
              ? (enabledTextColor ?? AppConstants.primaryBackground)
              : (disabledTextColor ?? const Color(0xFF999999)),
          elevation: isEnabled ? 2 : 0,
          shadowColor: isEnabled 
              ? (enabledColor ?? AppConstants.accentGreen).withValues(alpha: 0.3) 
              : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            side: BorderSide(
              color: isEnabled 
                  ? (enabledColor ?? AppConstants.accentGreen)
                  : const Color(0xFF666666),
              width: 1,
            ),
          ),
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
                  color: isEnabled 
                      ? (enabledTextColor ?? AppConstants.primaryBackground)
                      : (disabledTextColor ?? const Color(0xFF999999)),
                ),
              ),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final String text;
  final String? iconPath;
  final IconData? fallbackIcon;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final double iconSize;
  final double fontSize;

  const SocialButton({
    super.key,
    required this.text,
    this.iconPath,
    this.fallbackIcon,
    this.onPressed,
    this.width = 300,
    this.height = 35,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.iconSize = 20,
    this.fontSize = 15,
  });

  // Factory constructor para botão do Google
  factory SocialButton.google({
    VoidCallback? onPressed,
    double width = 300,
    double height = 35,
  }) {
    return SocialButton(
      text: 'Entrar com Google',
      iconPath: AppConstants.googleIconPath,
      fallbackIcon: Icons.login,
      onPressed: onPressed,
      width: width,
      height: height,
    );
  }

  // Factory constructor para botão do Discord
  factory SocialButton.discord({
    VoidCallback? onPressed,
    double width = 300,
    double height = 35,
  }) {
    return SocialButton(
      text: 'Entrar com Discord',
      iconPath: AppConstants.discordButtonIconPath,
      fallbackIcon: Icons.gamepad,
      onPressed: onPressed,
      width: width,
      height: height,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            side: BorderSide(
              color: Colors.grey.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIcon(),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (iconPath != null) {
      return Image.asset(
        iconPath!,
        width: iconSize,
        height: iconSize,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            fallbackIcon ?? Icons.login,
            size: iconSize,
            color: textColor,
          );
        },
      );
    } else if (fallbackIcon != null) {
      return Icon(
        fallbackIcon!,
        size: iconSize,
        color: textColor,
      );
    } else {
      return Icon(
        Icons.login,
        size: iconSize,
        color: textColor,
      );
    }
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