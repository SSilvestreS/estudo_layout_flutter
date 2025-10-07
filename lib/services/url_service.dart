import 'package:url_launcher/url_launcher.dart';
import '../constants/app_constants.dart';

/// Serviço para gerenciar URLs externas seguindo princípios DRY
class UrlService {
  /// Abre URL do site principal
  static Future<void> openWebsite() async {
    await _launchUrl(AppConstants.websiteUrl);
  }

  /// Abre URL do Instagram
  static Future<void> openInstagram() async {
    await _launchUrl(AppConstants.instagramUrl);
  }

  /// Abre URL do Discord
  static Future<void> openDiscord() async {
    await _launchUrl(AppConstants.discordUrl);
  }

  /// Método genérico para abrir URLs
  static Future<void> _launchUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      // Silenciar erros de URL para não interromper o fluxo da aplicação
    }
  }
}
