import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'building.dart';

/// 강남 타워의 색상 조합 데이터 클래스
class GangnamColorSet {
  final Color glassBase;
  final Color glassRef;
  final Color neon;
  final Color steel;
  final Color windowOn;

  const GangnamColorSet({
    required this.glassBase,
    required this.glassRef,
    required this.neon,
    required this.steel,
    required this.windowOn,
  });
}

/// 강남 타워 색상 프리셋
class GangnamColorPresets {
  static const GangnamColorSet cyberCyan = GangnamColorSet(
    glassBase: Color(0xFF102030),
    glassRef: Color(0xFF1A3A5A),
    neon: Color(0xFF00E5FF),
    steel: Color(0xFF455A64),
    windowOn: Color(0xFFE0F7FA),
  );

  static const GangnamColorSet emeraldGreen = GangnamColorSet(
    glassBase: Color(0xFF0A2010),
    glassRef: Color(0xFF153A20),
    neon: Color(0xFF00FF88),
    steel: Color(0xFF37474F),
    windowOn: Color(0xFFE8F5E9),
  );
}

/// 강남 스타일의 현대적인 유리 오피스 빌딩 - 고퀄리티 픽셀 아트
class GangnamTower extends Building {
  final math.Random _random = math.Random();
  final GangnamColorSet colorSet;
  
  static const double pSize = 2.0;

  GangnamTower({
    required super.position,
    double? width,
    double? height,
    super.buildingScale = 1.0,
    this.colorSet = GangnamColorPresets.cyberCyan,
  }) : super(
          width: (width ?? 80.0).clamp(60.0, 150.0),
          height: (height ?? 320.0).clamp(150.0, 500.0),
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
    final bodyPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [colorSet.glassRef, colorSet.glassBase],
      ).createShader(rect);
    canvas.drawRect(rect, bodyPaint);

    _drawModernFacade(canvas);
    _drawCyberNeonLines(canvas);
    _drawOfficeWindows(canvas);
    _drawRoofDetail(canvas);
  }

  void _drawModernFacade(Canvas canvas) {
    final paint = Paint()..color = Colors.black.withValues(alpha: 0.4);
    final double xStep = pSize * 8 * buildingScale;
    final double yStep = pSize * 10 * buildingScale;

    for (double x = pSize * 4 * buildingScale; x < size.x; x += xStep) {
      canvas.drawRect(Rect.fromLTWH(x, 0, pSize * 0.5 * buildingScale, size.y), paint);
    }
    for (double y = pSize * 10 * buildingScale; y < size.y; y += yStep) {
      canvas.drawRect(Rect.fromLTWH(0, y, size.x, pSize * 0.5 * buildingScale), paint);
    }

    final shinePaint = Paint()..color = Colors.white.withValues(alpha: 0.05);
    final path = Path()
      ..moveTo(pSize * 15 * buildingScale, 0)
      ..lineTo(size.x, size.y * 0.4)
      ..lineTo(size.x, size.y * 0.5)
      ..lineTo(pSize * 30 * buildingScale, 0)
      ..close();
    canvas.drawPath(path, shinePaint);
  }

  void _drawCyberNeonLines(Canvas canvas) {
    final paint = Paint()
      ..color = colorSet.neon
      ..style = PaintingStyle.stroke
      ..strokeWidth = pSize * 0.5 * buildingScale;
    
    canvas.drawLine(const Offset(0, 0), Offset(size.x * 0, size.y), paint);
    canvas.drawLine(Offset(size.x, 0), Offset(size.x, size.y), paint);

    final glowPaint = Paint()
      ..color = colorSet.neon.withValues(alpha: 0.15)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 6 * buildingScale);
    canvas.drawRect(Rect.fromLTWH(-pSize * buildingScale, 0, pSize * 2 * buildingScale, size.y), glowPaint);
    canvas.drawRect(Rect.fromLTWH(size.x - pSize * buildingScale, 0, pSize * 2 * buildingScale, size.y), glowPaint);
  }

  void _drawOfficeWindows(Canvas canvas) {
    final double fixedWinW = pSize * 3.0 * buildingScale;
    final double fixedWinH = pSize * 2.0 * buildingScale;
    final double gapX = pSize * 10 * buildingScale;
    final double gapY = pSize * 14 * buildingScale;

    for (double y = pSize * 20 * buildingScale; y < size.y - pSize * 25 * buildingScale; y += gapY) {
      for (double x = pSize * 5 * buildingScale; x < size.x - gapX; x += gapX) {
        if (_random.nextDouble() > 0.6) {
          final winColor = colorSet.windowOn.withValues(alpha: 0.8);
          canvas.drawRect(Rect.fromLTWH(x, y, fixedWinW, fixedWinH), Paint()..color = winColor);
          canvas.drawRect(Rect.fromLTWH(x - 1, y - 1, fixedWinW + 2, fixedWinH + 2), Paint()..color = winColor.withOpacity(0.1));
        }
      }
    }
  }

  void _drawRoofDetail(Canvas canvas) {
    final paint = Paint()..color = colorSet.steel;
    canvas.drawRect(Rect.fromLTWH(size.x * 0.3, -pSize * 4 * buildingScale, pSize * 8 * buildingScale, pSize * 4 * buildingScale), paint);
    canvas.drawRect(Rect.fromLTWH(size.x * 0.3 + pSize * 3 * buildingScale, -pSize * 12 * buildingScale, pSize * buildingScale, pSize * 8 * buildingScale), paint);
    
    paint.color = Colors.redAccent;
    canvas.drawCircle(Offset(size.x * 0.3 + pSize * 3.5 * buildingScale, -pSize * 12 * buildingScale), 1.2 * buildingScale, paint);
  }
}
