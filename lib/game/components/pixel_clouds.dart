import 'dart:math' as math;
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../coco_game.dart';
import '../utils/sky_colors.dart';

class PixelClouds extends PositionComponent with HasGameReference<CocoGame> {
  final List<_Cloud> _clouds = [];
  final math.Random _random = math.Random();

  PixelClouds() {
    priority = -80;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    size = game.camera.viewport.size;

    for (int i = 0; i < 8; i++) {
      _clouds.add(_Cloud(
        x: _random.nextDouble() * size.x,
        y: _random.nextDouble() * 200 + 50,
        speed: _random.nextDouble() * 15 + 5,
        scale: _random.nextDouble() * 0.6 + 0.7,
      ));
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // 카메라 위치를 따라가도록 설정
    position = game.camera.viewfinder.position - game.camera.viewport.size / 2;
    size = game.camera.viewport.size;

    for (var cloud in _clouds) {
      cloud.x += cloud.speed * dt;
      // viewport 너비를 기준으로 순환
      if (cloud.x > size.x + 100) cloud.x = -200;
    }
  }

  @override
  void render(Canvas canvas) {
    final colors = SkyColors.getCloudColors();

    for (var cloud in _clouds) {
      _drawStylizedCloud(canvas, cloud.x, cloud.y, cloud.scale, colors.main, colors.shadow);
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
