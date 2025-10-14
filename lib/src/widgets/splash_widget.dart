import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AnimatedLoadingDots extends StatefulWidget {
  const AnimatedLoadingDots({super.key});

  @override
  State<AnimatedLoadingDots> createState() => _AnimatedLoadingDotsState();
}

class _AnimatedLoadingDotsState extends State<AnimatedLoadingDots> {
  int _dotCount = 1;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 400));
      if (!mounted) return false;
      setState(() {
        _dotCount = (_dotCount % 3) + 1;
      });
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dots = '.' * _dotCount;
    return Text(
      'Carregando$dots',
      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
    );
  }
}

class SplashWidget extends StatelessWidget {
  final String logoAsset;
  final String backgroundAsset;
  const SplashWidget({super.key, required this.logoAsset, required this.backgroundAsset});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // background image asset
        Positioned.fill(
          child: Image.asset(
            backgroundAsset,
            fit: BoxFit.cover,
          ),
        ),
        // overlay for contrast
        Positioned.fill(
          child: Container(color: Colors.black.withOpacity(0.35)),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Spacer(flex: 2),
              // app logo (asset)
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: ClipOval(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      logoAsset,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        // fallback to default icon if asset missing
                        return const Icon(
                          Icons.flutter_dash,
                          size: 56,
                          color: AppTheme.primaryColor,
                        );
                      },
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 3),
              // bottom-aligned indicator and text inside Padding to avoid touching edge
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    SizedBox(height: 12),
                    AnimatedLoadingDots(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
