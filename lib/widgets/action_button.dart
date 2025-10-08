///aqui fica somente os codigos de widgets de acao - evita duplicacao de codigo em outros arquivos

import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// widget generico para botoes de acao (continuar, entrar, enviar, cadastrar, etc.) - espero que essa merda n quebre dnv 
class ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isValid;
  final double width;
  final double height;
  final double fontSize;
  final Color? enabledColor;
  final Color? disabledColor;
  final Color? enabledTextColor;
  final Color? disabledTextColor;

  const ActionButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isValid = true,
    this.width = 180,
    this.height = 45,
    this.fontSize = 15,
    this.enabledColor,
    this.disabledColor,
    this.enabledTextColor,
    this.disabledTextColor,
  });

  /// factory constructor para botao de continuar
  factory ActionButton.continueButton({
    required VoidCallback? onPressed,
    required bool isValid,
    double width = 180,
    double height = 45,
  }) {
    return ActionButton(
      text: 'CONTINUAR',
      onPressed: onPressed,
      isValid: isValid,
      width: width,
      height: height,
    );
  }

  /// factory constructor para botao de entrar
  factory ActionButton.loginButton({
    required VoidCallback? onPressed,
    required bool isValid,
    double width = 180,
    double height = 45,
  }) {
    return ActionButton(
      text: 'ENTRAR',
      onPressed: onPressed,
      isValid: isValid,
      width: width,
      height: height,
    );
  }

  /// factory constructor para botao de enviar
  factory ActionButton.sendButton({
    required VoidCallback? onPressed,
    required bool isValid,
    double width = 180,
    double height = 45,
  }) {
    return ActionButton(
      text: 'ENVIAR',
      onPressed: onPressed,
      isValid: isValid,
      width: width,
      height: height,
    );
  }

  /// factory constructor para botao de cadastro
  factory ActionButton.registerButton({
    required VoidCallback? onPressed,
    required bool isValid,
    double width = 180,
    double height = 45,
  }) {
    return ActionButton(
      text: 'CADASTRAR',
      onPressed: onPressed,
      isValid: isValid,
      width: width,
      height: height,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = isValid && onPressed != null;
    
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled 
              ? (enabledColor ?? const Color(0xFF7BFF00))
              : (disabledColor ?? const Color(0xFF555555)),
          foregroundColor: isEnabled 
              ? (enabledTextColor ?? const Color(0xFF1A0033))
              : (disabledTextColor ?? const Color(0xFF999999)),
          elevation: isEnabled ? 2 : 0,
          shadowColor: isEnabled 
              ? (enabledColor ?? const Color(0xFF7BFF00)).withValues(alpha: 0.3) 
              : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(
              color: isEnabled 
                  ? (enabledColor ?? const Color(0xFF7BFF00))
                  : const Color(0xFF666666),
              width: 1,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: isEnabled 
                ? (enabledTextColor ?? const Color(0xFF1A0033))
                : (disabledTextColor ?? const Color(0xFF999999)),
          ),
        ),
      ),
    );
  }
}

/// widget para botao voltar
class BackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final EdgeInsets padding;

  const BackButton({
    super.key,
    this.onPressed,
    this.text = 'voltar',
    this.backgroundColor = Colors.transparent,
    this.textColor = AppConstants.textWhite,
    this.fontSize = 14,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () => Navigator.pop(context),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.arrow_back_ios, 
              color: textColor, 
              size: 16,
            ),
            const SizedBox(width: 6),
            Text(
              text,
              style: TextStyle(
                color: textColor, 
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// widget para logo da gb
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
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: const Color(0xFF7BFF00),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'GB',
                style: TextStyle(
                  color: Color(0xFF1A0033),
                  fontSize: 20,
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
