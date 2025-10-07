import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_constants.dart';

class UrlService {
  static Future<void> openWebsite() async {
    try {
      final uri = Uri.parse(AppConstants.websiteUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('Não foi possível abrir o site: ${AppConstants.websiteUrl}');
      }
    } catch (e) {
      debugPrint('Erro ao abrir o site: $e');
    }
  }

  static Future<void> openInstagram() async {
    try {
      final uri = Uri.parse(AppConstants.instagramUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('Não foi possível abrir o Instagram: ${AppConstants.instagramUrl}');
      }
    } catch (e) {
      debugPrint('Erro ao abrir o Instagram: $e');
    }
  }

  static Future<void> openDiscord() async {
    try {
      final uri = Uri.parse(AppConstants.discordUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('Não foi possível abrir o Discord: ${AppConstants.discordUrl}');
      }
    } catch (e) {
      debugPrint('Erro ao abrir o Discord: $e');
    }
  }
}