import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import '../constants/app_constants.dart';

/// Componente reutilizável para painel de vídeo com texto e ícones sociais
class VideoPanel extends StatefulWidget {
  final List<SocialIconData> socialIcons;
  final VoidCallback? onIconTap;

  const VideoPanel({
    super.key,
    required this.socialIcons,
    this.onIconTap,
  });

  @override
  State<VideoPanel> createState() => _VideoPanelState();
}

class _VideoPanelState extends State<VideoPanel> {
  late final Player _player;
  late final VideoController _videoController;
  bool _isVideoLoaded = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      _player = Player();
      _videoController = VideoController(_player);
      await _player.open(Media(AppConstants.videoPath));
      await _player.setPlaylistMode(PlaylistMode.loop);
      await _player.setVolume(0.0);
      await _player.play();
      
      if (mounted) {
        setState(() {
          _isVideoLoaded = true;
        });
      }
    } catch (e) {
      debugPrint('Erro ao carregar vídeo: $e');
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final panelWidth = constraints.maxWidth;
        final panelHeight = constraints.maxHeight;
        
        // Calcular posições baseadas em porcentagens para manter proporções
        final textLeft = panelWidth * 0.12;
        final textTop1 = panelHeight * 0.71;
        final textTop2 = panelHeight * 0.76;
        final iconsTop = panelHeight * 0.84;
        
        return Stack(
          children: [
            // Vídeo/imagem de fundo
            Positioned.fill(
              child: _isVideoLoaded ? _buildVideoPanel() : _buildLoadingPanel(),
            ),
            // Texto "the game"
            Positioned(
              left: textLeft,
              top: textTop1,
              child: const Text(
                AppConstants.gameText,
                style: TextStyle(
                  color: AppConstants.textWhite,
                  fontSize: 28,
                  fontStyle: FontStyle.italic,
                  shadows: [Shadow(offset: Offset(0, 1), blurRadius: 3, color: Colors.black54)],
                ),
              ),
            ),
            // Texto "FOR GAMERS"
            Positioned(
              left: textLeft,
              top: textTop2,
              child: const Text(
                AppConstants.gamersText,
                style: TextStyle(
                  color: AppConstants.accentGreen,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(offset: Offset(0, 2), blurRadius: 4, color: Colors.black87)],
                ),
              ),
            ),
            // Ícones sociais
            Positioned(
              left: textLeft,
              top: iconsTop,
              child: Row(
                children: widget.socialIcons.map((iconData) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: SocialIcon(
                      icon: iconData.icon,
                      imagePath: iconData.imagePath,
                      fallbackIcon: iconData.fallbackIcon,
                      onTap: () {
                        if (widget.onIconTap != null) {
                          widget.onIconTap!();
                        }
                        _showMessage(iconData.message);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildVideoPanel() {
    return Stack(
      children: [
        Positioned.fill(
          child: Video(
            controller: _videoController,
            fit: BoxFit.cover,
            controls: NoVideoControls,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 0.3),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingPanel() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppConstants.primaryBackground, Color(0xFF2D1B69)],
        ),
      ),
      child: const Center(
        child: CircularProgressIndicator(
          color: AppConstants.accentGreen,
        ),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppConstants.accentGreen,
      ),
    );
  }
}

/// Componente para ícone social individual
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

/// Classe de dados para ícones sociais
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
}
