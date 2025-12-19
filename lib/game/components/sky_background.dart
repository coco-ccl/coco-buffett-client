import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class SkyBackground extends PositionComponent with HasGameReference {
  SkyBackground() {
    priority = -100;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    size = game.size;
  }

  @override
  void render(Canvas canvas) {
    final now = DateTime.now();
    final hour = now.hour + (now.minute / 60.0);
    
    final fullRect = Rect.fromLTWH(0, 0, size.x, size.y);
    Color topColor;
    Color bottomColor;

    if (hour >= 5 && hour < 7) { // 새벽
      topColor = const Color(0xFF1A0F21);
      bottomColor = const Color(0xFFE57373);
    } else if (hour >= 7 && hour < 17) { // 낮
      topColor = const Color(0xFF4FC3F7);
      bottomColor = const Color(0xFF81D4FA);
    } else if (hour >= 17 && hour < 19) { // 노을
      topColor = const Color(0xFF2D1B36);
      bottomColor = const Color(0xFFF4511E);
    } else { // 밤
      topColor = const Color(0xFF020205);
      bottomColor = const Color(0xFF0D0D25);
    }

    final skyPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [topColor, bottomColor],
      ).createShader(fullRect);
    canvas.drawRect(fullRect, skyPaint);
  }
}
