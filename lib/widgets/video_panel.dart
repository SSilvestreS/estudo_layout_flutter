import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../services/url_service.dart';
import 'app_components.dart';
import 'social_button.dart';

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

class _VideoPanelState extends State<VideoPanel> with TickerProviderStateMixin {
  // TODO: adicionar video futuramente
  // Player? _mediaKitPlayer;
  // VideoController? _mediaKitVideoController;
  // VideoPlayerController? _videoPlayerController;
  // bool _isVideoLoaded = false;
  
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
  }

  void _initializeAnimation() {
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    
    _colorAnimation = ColorTween(
      begin: AppConstants.primaryBackground,
      end: const Color(0xFF2D1B69),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _animationController.repeat(reverse: true);
  }

  // TODO: implementar carregamento de video futuramente
  // Future<void> _initializeVideo() async {
  //   // Implementação do vídeo vai vim aqui!!
  // }

  @override
  void dispose() {
    _animationController.dispose();
    // TODO: dispose dos controllers de video quando implementado
    // _mediaKitPlayer?.dispose();
    // _videoPlayerController?.dispose();
    /// queria muito fazer essa merda funcionar, mas ta dificil pqp
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final panelWidth = constraints.maxWidth;
        final panelHeight = constraints.maxHeight;
        
        
        final textLeft = panelWidth * 0.18; 
        final textTop1 = panelHeight * 0.55;
        final textTop2 = panelHeight * 0.60;
        final iconsTop = panelHeight * 0.72; 
        
        return Stack(
          children: [
            Positioned.fill(
              child: _buildAnimatedPanel(),
            ),
            Positioned(
              left: textLeft,
              top: textTop1,
              child: const Text(
                AppConstants.gameText,
                style: TextStyle(
                  color: AppConstants.textWhite,
                  fontSize: 36,
                  fontStyle: FontStyle.italic,
                  shadows: [Shadow(offset: Offset(0, 1), blurRadius: 3, color: Colors.black54)],
                ),
              ),
            ),

            Positioned(
              left: textLeft,
              top: textTop2,
              child: const Text(
                AppConstants.gamersText,
                style: TextStyle(
                  color: AppConstants.accentGreen,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(offset: Offset(0, 2), blurRadius: 4, color: Colors.black87)],
                ),
              ),
            ),

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
                        _handleIconTap(iconData);
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

  Widget _buildAnimatedPanel() {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _colorAnimation.value ?? AppConstants.primaryBackground,
                const Color(0xFF2D1B69),
              ],
            ),
          ),
        );
      },
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

  void _handleIconTap(SocialIconData iconData) {
    
    if (iconData.icon == Icons.camera_alt) {
      UrlService.openInstagram();
    } 
    
    else if (iconData.icon == Icons.gamepad || iconData.imagePath != null) {
      UrlService.openDiscord();
    } 
    else {
      
      _showMessage(iconData.message);
    }
  }
}

