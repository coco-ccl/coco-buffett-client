import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'building.dart';

/// 호텔 빌딩의 색상 조합 데이터 클래스
class HotelColorSet {
  final Color main;
  final Color shadow;
  final Color highlight;
  final Color windowOn;
  final Color neon;
  final Color canopy;

  const HotelColorSet({
    required this.main,
    required this.shadow,
    required this.highlight,
    required this.windowOn,
    required this.neon,
    required this.canopy,
  });
}

/// 호텔 색상 프리셋
class HotelColorPresets {
  static const HotelColorSet boutiquePurple = HotelColorSet(
    main: Color(0xFF2D1B36),
    shadow: Color(0xFF1A0F21),
    highlight: Color(0xFF4A2C59),
    windowOn: Color(0xFFFFD54F),
    neon: Color(0xFFF06292),
    canopy: Color(0xFFC62828),
  );

  static const HotelColorSet modernBlack = HotelColorSet(
    main: Color(0xFF121212),
    shadow: Color(0xFF000000),
    highlight: Color(0xFF333333),
    windowOn: Color(0xFFE0F7FA),
    neon: Color(0xFF00E5FF),
    canopy: Color(0xFF455A64),
  );
}

class HotelBuilding extends Building {
  final math.Random _random = math.Random();
  final HotelColorSet colorSet;
  
  static const double pSize = 2.0;

  HotelBuilding({
    required super.position,
    double? width,
    double? height,
    super.buildingScale = 1.0,
    this.colorSet = HotelColorPresets.boutiquePurple,
  }) : super(
          width: (width ?? 110.0).clamp(80.0, 180.0),
          height: (height ?? 280.0).clamp(150.0, 400.0),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox(
      position: Vector2(0, size.y - 15),
      size: Vector2(size.x, 15),
    ));
  }

  @override
  void render(Canvas canvas) {
    final rect = size.toRect();
    canvas.drawRect(rect, Paint()..color = colorSet.main);
    canvas.drawRect(Rect.fromLTWH(rect.right - (pSize * 4 * buildingScale), 0, pSize * 4 * buildingScale, size.y), Paint()..color = colorSet.shadow);
    canvas.drawRect(Rect.fromLTWH(0, 0, pSize * buildingScale, size.y), Paint()..color = colorSet.highlight);

    _drawHotelWindows(canvas);
    _drawVerticalNeonSign(canvas);
    _drawEntrance(canvas);
  }

  void _drawHotelWindows(Canvas canvas) {
    final double winW = pSize * 3.5 * buildingScale;
    final double winH = pSize * 4.5 * buildingScale;
    final double gapX = pSize * 6.0 * buildingScale;
    final double gapY = pSize * 10.0 * buildingScale;

    for (double y = pSize * 15 * buildingScale; y < size.y - (pSize * 25 * buildingScale); y += gapY + winH) {
      for (double x = pSize * 8 * buildingScale; x < size.x - (pSize * 20 * buildingScale); x += gapX + winW) {
        if (_random.nextDouble() > 0.3) {
          canvas.drawRect(Rect.fromLTWH(x, y, winW, winH), Paint()..color = colorSet.windowOn.withValues(alpha: 0.8));
          canvas.drawRect(Rect.fromLTWH(x + winW/2, y, 1 * buildingScale, winH), Paint()..color = Colors.black.withValues(alpha: 0.1));
        } else {
          canvas.drawRect(Rect.fromLTWH(x, y, winW, winH), Paint()..color = Colors.black.withValues(alpha: 0.4));
        }
      }
    }
  }

  void _drawVerticalNeonSign(Canvas canvas) {
    final signX = size.x - (pSize * 10 * buildingScale);
    final signY = pSize * 12 * buildingScale;
    final signW = pSize * 6 * buildingScale;
    final signH = pSize * 30 * buildingScale;

    canvas.drawRect(Rect.fromLTWH(signX, signY, signW, signH), Paint()..color = const Color(0xFF0A0A0A));
    canvas.drawRect(
      Rect.fromLTWH(signX, signY, signW, signH),
      Paint()..color = colorSet.neon..style = PaintingStyle.stroke..strokeWidth = buildingScale * 1.5,
    );
    canvas.drawCircle(
      Offset(signX + signW/2, signY + signH/2), 
      signH/2, 
      Paint()
        ..color = colorSet.neon.withValues(alpha: 0.1)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 8 * buildingScale)
    );
  }

  void _drawEntrance(Canvas canvas) {
    final canopyW = size.x * 0.75;
    final canopyH = pSize * 6 * buildingScale;
    final canopyX = (size.x - canopyW) / 2;
    final canopyY = size.y - (pSize * 12 * buildingScale);

    canvas.drawRect(Rect.fromLTWH(canopyX + 5 * buildingScale, canopyY, canopyW - 10 * buildingScale, pSize * 12 * buildingScale), Paint()..color = Colors.black);
    canvas.drawRect(Rect.fromLTWH(canopyX, canopyY, canopyW, canopyH), Paint()..color = colorSet.canopy);
  }
}
