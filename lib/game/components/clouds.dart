import 'dart:math' as math;
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class PixelClouds extends Component with HasGameReference {
  final List<_Cloud> _clouds = [];
  final math.Random _random = math.Random();

  @override
  Future<void> onLoad() async {
    for (int i = 0; i < 10; i++) {
      _clouds.add(_Cloud(
        x: _random.nextDouble() * 2000,
        y: _random.nextDouble() * 250 + 50,
        speed: _random.nextDouble() * 15 + 5,
        width: _random.nextDouble() * 80 + 60,
      ));
    }
  }

  @override
  void update(double dt) {
    for (var cloud in _clouds) {
      cloud.x += cloud.speed * dt;
      // 화면 끝으로 가면 다시 왼쪽에서 등장 (무한 루프)
      if (cloud.x > game.size.x + 200) cloud.x = -200;
    }
  }

  @override
  void render(Canvas canvas) {
    final now = DateTime.now();
    final hour = now.hour + (now.minute / 60.0);
    
    // 시간대에 따른 구름 색상 (낮: 하양, 노을: 오렌지, 밤: 짙은 네이비)
    Color baseColor;
    if (hour >= 7 && hour < 17) {
      baseColor = Colors.white.withOpacity(0.3);
    } else if (hour >= 17 && hour < 19) {
      baseColor = Colors.orangeAccent.withOpacity(0.4);
    } else {
      baseColor = const Color(0xFF1A1A2E).withOpacity(0.2);
    }

    final paint = Paint()..color = baseColor;

    for (var cloud in _clouds) {
      _drawPixelCloud(canvas, cloud.x, cloud.y, cloud.width, paint);
    }
  }

  /// 픽셀 덩어리를 조합하여 입체적인 구름을 그림
  void _drawPixelCloud(Canvas canvas, double x, double y, double w, Paint paint) {
    // 중앙 몸통
    canvas.drawRect(Rect.fromLTWH(x, y, w, 20), paint);
    // 위쪽 뭉게구름 (도트 덩어리)
    canvas.drawRect(Rect.fromLTWH(x + w * 0.2, y - 10, w * 0.5, 10), paint);
    canvas.drawRect(Rect.fromLTWH(x + w * 0.4, y - 18, w * 0.3, 8), paint);
    // 아래쪽 명암 (디테일)
    canvas.drawRect(Rect.fromLTWH(x + 10, y + 20, w - 20, 5), paint.withOpacity(paint.color.opacity * 0.5));
  }
}

class _Cloud {
  double x, y, speed, width;
  _Cloud({required this.x, required this.y, required this.speed, required this.width});
}
