import 'package:flutter/material.dart';

/// Constantes globais da aplicação seguindo princípios DRY
class AppConstants {
  // Cores
  static const Color primaryBackground = Color(0xFF1A0033);
  static const Color accentGreen = Color(0xFF7BFF00);
  static const Color inputBackground = Color(0xFF333333);
  static const Color textWhite = Colors.white;
  static const Color textLightGray = Color(0xFFCCCCCC);
  
  // Dimensões
  static const double logoHeight = 60.0;
  static const double buttonHeight = 45.0;
  static const double inputHeight = 50.0;
  static const double borderRadius = 6.0;
  static const double iconSize = 20.0;
  static const double socialIconSize = 36.0;
  
  // Espaçamentos
  static const EdgeInsets defaultPadding = EdgeInsets.all(40.0);
  
  // Assets
  static const String logoPath = 'assets/images/logo_gamersbrawl.png';
  static const String videoPath = 'assets/videos/background_video.mp4';
  static const String discordIconPath = 'assets/images/discord_social_icon.png';
  
  // Textos
  static const String appTitle = 'Gamers Brawl';
  static const String gameText = 'the game';
  static const String gamersText = 'FOR GAMERS';
  
  // Validações
  static const int minPasswordLength = 6;
  static const int maxEmailLength = 100;
}
