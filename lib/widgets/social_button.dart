///aqui fica somente os codigos de widgets de botoes sociais
import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class SocialIconData {
  final IconData? icon;
  final String? imagePath;
  final IconData? fallbackIcon;
  final String message;

  const SocialIconData({
    this.icon,
    this.imagePath,
    this.fallbackIcon,
    required this.message,
  });

  static List<SocialIconData> getDefaultSocialIcons() {
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
}

/// widget generico para botoes sociais (google, discord, etc.) dica do kim
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

  /// factory constructor para botao do gogle
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

  /// factory constructor para botao do discord
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
            borderRadius: BorderRadius.circular(6),
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
