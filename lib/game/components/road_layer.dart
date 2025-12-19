import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

enum RoadTileStyle { asphalt, sidewalk, marble }

class RoadLayer extends PositionComponent with HasGameReference {
  final RoadTileStyle style;
  final double tileSize = 32.0;

  RoadLayer({
    required Vector2 position,
    required Vector2 size,
    this.style = RoadTileStyle.asphalt,
  }) : super(position: position, size: size) {
    priority = -80;
  }

  @override
  void render(Canvas canvas) {
    final now = DateTime.now();
    final hour = now.hour + (now.minute / 60.0);
    double brightness = (hour >= 7 && hour < 17) ? 1.0 : 0.4;
    if (hour >= 17 && hour < 19) brightness = 0.7;

    for (double y = 0; y < size.y; y += tileSize) {
      for (double x = 0; x < size.x; x += tileSize) {
        _drawTile(canvas, x, y, brightness);
      }
    }
  }

  void _drawTile(Canvas canvas, double x, double y, double brightness) {
    final rect = Rect.fromLTWH(x, y, tileSize, tileSize);
    final paint = Paint();

    switch (style) {
      case RoadTileStyle.asphalt:
        paint.color = const Color(0xFF1C1C1E).withOpacity(brightness);
        canvas.drawRect(rect, paint);
        paint.color = Colors.white.withOpacity(0.03 * brightness);
        canvas.drawRect(Rect.fromLTWH(x + 4, y + 8, 2, 2), paint);
        canvas.drawRect(Rect.fromLTWH(x + 22, y + 18, 2, 2), paint);
        break;

      case RoadTileStyle.sidewalk:
        paint.color = const Color(0xFF2C2C2E).withOpacity(brightness);
        canvas.drawRect(rect, paint);
        paint.color = Colors.black.withOpacity(0.4 * brightness);
        canvas.drawRect(Rect.fromLTWH(x, y, tileSize, 1), paint);
        canvas.drawRect(Rect.fromLTWH(x, y, 1, tileSize), paint);
        paint.color = Colors.white.withOpacity(0.05 * brightness);
        canvas.drawRect(Rect.fromLTWH(x, y + tileSize - 1, tileSize, 1), paint);
        break;

      case RoadTileStyle.marble:
        paint.color = const Color(0xFF37474F).withOpacity(brightness);
        canvas.drawRect(rect, paint);
        paint.color = Colors.white.withOpacity(0.05 * brightness);
        canvas.drawLine(Offset(x, y), Offset(x + tileSize, y + tileSize), paint);
        break;
    }
  }
}
