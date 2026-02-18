import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class FruitRush extends FlameGame {
  @override
  void render(Canvas canvas) {
    final rect = size.toRect();

    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFB3E5FC), Color(0xFF4FC3F7), Color(0xFF0288D1)],
      ).createShader(rect);

    canvas.drawRect(rect, paint);

    super.render(canvas);
  }

  final ValueNotifier<int> scoreNotifier = ValueNotifier<int>(0);
}
