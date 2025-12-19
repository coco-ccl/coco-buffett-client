import 'dart:math' as math;
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class PixelClouds extends Component with HasGameReference {
  final List<_Cloud> _clouds = [];
  final math.Random _random = math.Random();

  @override
  Future<void> onLoad() async {
    for (int i = 0; i < 8; i++) {
      _clouds.add(_Cloud(
        x: _random.nextDouble() * 1200,
        y: _random.nextDouble() * 200 + 50,
        speed: _random.nextDouble() * 15 + 5,
        scale: _random.nextDouble() * 0.6 + 0.7,
      ));
    }
  }

  @override
  void update(double dt) {
    for (var cloud in _clouds) {
      cloud.x += cloud.speed * dt;
      // 화면 너비를 기준으로 순환 (Viewport 기준)
      if (cloud.x > game.size.x + 100) cloud.x = -200;
    }
  }

  @override
  void render(Canvas canvas) {
    final now = DateTime.now();
    final hour = now.hour + (now.minute / 60.0);
    
    Color mainColor;
    Color shadowColor;

    if (hour >= 7 && hour < 17) { // 낮
      mainColor = Colors.white.withValues(alpha: 0.7);
      shadowColor = const Color(0xFFB0BEC5).withValues(alpha: 0.5);
    } else if (hour >= 17 && hour < 19) { // 노을
      mainColor = Colors.orangeAccent.withValues(alpha: 0.7);
      shadowColor = Colors.deepOrange.withValues(alpha: 0.5);
    } else { // 밤
      mainColor = const Color(0xFF1A1A2E).withValues(alpha: 0.3);
      shadowColor = Colors.black.withValues(alpha: 0.2);
    }

    for (var cloud in _clouds) {
      _drawStylizedCloud(canvas, cloud.x, cloud.y, cloud.scale, mainColor, shadowColor);
    }
  }

  void _drawStylizedCloud(Canvas canvas, double x, double y, double scale, Color main, Color shadow) {
    final p = Paint()..color = main;
    final s = Paint()..color = shadow;

    // 1. 하단 음영 레이어 (픽셀 덩어리들을 겹쳐서 부드럽고 입체적으로 표현)
    canvas.drawRect(Rect.fromLTWH(x + 10 * scale, y + 15 * scale, 80 * scale, 15 * scale), s);
    canvas.drawRect(Rect.fromLTWH(x + 25 * scale, y + 22 * scale, 50 * scale, 10 * scale), s);

    // 2. 메인 구름 몸체
    canvas.drawRect(Rect.fromLTWH(x, y + 5 * scale, 100 * scale, 15 * scale), p); // 베이스
    canvas.drawRect(Rect.fromLTWH(x + 15 * scale, y - 10 * scale, 45 * scale, 20 * scale), p); // 왼쪽 봉우리
    canvas.drawRect(Rect.fromLTWH(x + 45 * scale, y - 20 * scale, 35 * scale, 30 * scale), p); // 메인 봉우리
    canvas.drawRect(Rect.fromLTWH(x + 75 * scale, y, 20 * scale, 15 * scale), p); // 오른쪽 봉우리
    
    // 3. 디테일 하이라이트 (가장 윗부분에 1픽셀 도트 포인트)
    canvas.drawRect(Rect.fromLTWH(x + 50 * scale, y - 22 * scale, 10 * scale, 2 * scale), Paint()..color = Colors.white.withOpacity(0.3));
  }
}

class _Cloud {
  double x, y, speed, scale;
  _Cloud({required this.x, required this.y, required this.speed, required this.scale});
}
