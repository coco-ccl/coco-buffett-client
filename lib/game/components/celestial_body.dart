import 'dart:math' as math;
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../coco_game.dart';

class CelestialBody extends PositionComponent with HasGameReference<CocoGame> {
  CelestialBody() {
    priority = -90;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    size = game.camera.viewport.size;
  }

  @override
  void update(double dt) {
    super.update(dt);
    // 카메라 위치를 따라가도록 설정
    position = game.camera.viewfinder.position - game.camera.viewport.size / 2;
    size = game.camera.viewport.size;
  }

  @override
  void render(Canvas canvas) {
    final now = DateTime.now();
    final hour = now.hour + (now.minute / 60.0);

    // 6시부터 18시까지는 해, 그 외에는 달
    final bool isDay = hour >= 6 && hour < 18;

    // 궤적 계산 (6시~18시: 0~1, 18시~6시: 0~1)
    double progress;
    if (isDay) {
      progress = (hour - 6) / 12;
    } else {
      progress = hour < 6 ? (hour + 6) / 12 : (hour - 18) / 12;
    }

    final double cx = size.x * progress;
    // 포물선 궤적 (가운데가 높고 양끝이 낮은 형태)
    final double cy = 250 + math.sin(progress * math.pi) * -200;

    if (isDay) {
      _drawSun(canvas, cx, cy);
    } else {
      _drawMoon(canvas, cx, cy);
    }
  }

  void _drawSun(Canvas canvas, double x, double y) {
    // 해 본체
    canvas.drawCircle(Offset(x, y), 35, Paint()..color = const Color(0xFFFFD54F));
    // 해 광채 (Glow)
    canvas.drawCircle(
      Offset(x, y), 
      50, 
      Paint()..color = Colors.orange.withValues(alpha: 0.2)..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15)
    );
  }

  void _drawMoon(Canvas canvas, double x, double y) {
    // 달 본체 (살짝 노란빛 도는 흰색)
    canvas.drawCircle(Offset(x, y), 30, Paint()..color = const Color(0xFFF4F4F4));
    
    // 달의 입체감 (그림자 포인트)
    canvas.drawCircle(
      Offset(x - 5, y + 5), 
      5, 
      Paint()..color = Colors.black.withValues(alpha: 0.05)
    );

    // 달 광채
    canvas.drawCircle(
      Offset(x, y), 
      40, 
      Paint()..color = Colors.white.withValues(alpha: 0.1)..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10)
    );
  }
}
