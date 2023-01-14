import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../const/colors.dart';
import 'animations/animated_appearance.dart';

const _defaultBackgroundColor = WBColors.transparent;
const _defaultColor = WBColors.primary;

class LinearLoader extends StatelessWidget {
  final Color color;

  const LinearLoader({this.color = _defaultColor}) : super(key: null);

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: _defaultBackgroundColor,
      valueColor: AlwaysStoppedAnimation(color),
    );
  }
}

class CircularLoader extends StatelessWidget {
  final Color color;
  final double size;
  final double strokeWidth;

  const CircularLoader({
    this.color = _defaultColor,
    this.size = 00,
    this.strokeWidth = 4,
  }) : super(key: null);

  @override
  Widget build(BuildContext context) {
    return Lottie.asset('assets/animations/loader2.json');
  }
}

class BlockingLoader extends StatelessWidget {
  final bool isLoading;
  final String message;
  final Widget child;

  const BlockingLoader({
    required this.isLoading,
    this.message = '',
    required this.child,
    super.key,
  });

  Widget _buildLoadingBlocker() {
    return AnimatedAppearance(
      visible: isLoading,
      duration: const Duration(milliseconds: 120),
      childBuilder: (_) => Container(
        color: WBColors.black.withOpacity(0.5),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularLoader(color: WBColors.white),
              if (message.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: WBColors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        child,
        _buildLoadingBlocker(),
      ],
    );
  }
}