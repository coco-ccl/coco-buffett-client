import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../coco_game.dart';
import '../utils/sky_colors.dart';

class SkyBackground extends PositionComponent with HasGameReference<CocoGame> {
  final double mapWidth;
  final double mapHeight;

  SkyBackground({required this.mapWidth, required this.mapHeight}) {
    priority = -100;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    size = Vector2(mapWidth, mapHeight);
    position = Vector2.zero();
  }

  @override
  void update(double dt) {
    super.update(dt);
    // 배경은 항상 맵 전체를 덮도록 위치 고정
    position = Vector2.zero();
    size = Vector2(mapWidth, mapHeight);
  }

  @override
  void render(Canvas canvas) {
    final fullRect = Rect.fromLTWH(0, 0, size.x, size.y);
    final colors = SkyColors.getSkyColors();

    final skyPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [colors.top, colors.bottom],
      ).createShader(fullRect);
    canvas.drawRect(fullRect, skyPaint);
  }
}
