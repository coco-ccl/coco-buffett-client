import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'building.dart';

/// 엠파이어 빌딩의 색상 조합 데이터 클래스
class EmpireColorSet {
  final Color main;
  final Color shadow;
  final Color highlight;
  final Color windowOn;
  final Color windowOff;
  final Color neon;

  const EmpireColorSet({
    required this.main,
    required this.shadow,
    required this.highlight,
    required this.windowOn,
    required this.windowOff,
    required this.neon,
  });
}

/// 엠파이어 빌딩 색상 프리셋
class EmpireColorPresets {
  static const EmpireColorSet midnightBlue = EmpireColorSet(
    main: Color(0xFF161B33),
    shadow: Color(0xFF0D0F1F),
    highlight: Color(0xFF2D3250),
    windowOn: Color(0xFFFFF59D),
    windowOff: Color(0xFF101025),
    neon: Color(0xFFFF4081),
  );

  static const EmpireColorSet classicGrey = EmpireColorSet(
    main: Color(0xFF455A64),
    shadow: Color(0xFF263238),
    highlight: Color(0xFF78909C),
    windowOn: Color(0xFFFFECB3),
    windowOff: Color(0xFF1A1A1A),
    neon: Color(0xFF00E5FF),
  );
}

class EmpireBuilding extends Building {
  final math.Random _random = math.Random();
  final EmpireColorSet colorSet;
  
  static const double pSize = 2.0;

  EmpireBuilding({
    required super.position,
    double? width,
    double? height,
    super.buildingScale = 1.0,
    this.colorSet = EmpireColorPresets.midnightBlue,
  }) : super(
          width: (width ?? 70.0).clamp(50.0, 150.0),
          height: (height ?? 320.0).clamp(200.0, 800.0),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox(
      position: Vector2(0, size.y - 20),
      size: Vector2(size.x, 20),
    ));
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint();
    
    final List<_Section> sections = [
      _Section(wPct: 1.0, hPct: 0.35),
      _Section(wPct: 0.8, hPct: 0.3),
      _Section(wPct: 0.6, hPct: 0.2),
      _Section(wPct: 0.3, hPct: 0.15),
    ];

    double currentY = size.y;
    for (int i = 0; i < sections.length; i++) {
      final s = sections[i];
      final sW = size.x * s.wPct;
      final sH = size.y * s.hPct;
      final sX = (size.x - sW) / 2;
      final sRect = Rect.fromLTWH(sX, currentY - sH, sW, sH);

      canvas.drawRect(sRect, paint..color = colorSet.main);
      canvas.drawRect(Rect.fromLTWH(sRect.right - (pSize * 3 * buildingScale), sRect.top, pSize * 3 * buildingScale, sRect.height), paint..color = colorSet.shadow);
      canvas.drawRect(Rect.fromLTWH(sRect.left, sRect.top, pSize * buildingScale, sRect.height), paint..color = colorSet.highlight);

      _drawPixelWindows(canvas, sRect);
      currentY -= sH;
    }

    _drawSpire(canvas, currentY);
  }

  void _drawPixelWindows(Canvas canvas, Rect rect) {
    final winW = pSize * 3.5 * buildingScale;
    final winH = pSize * 4.5 * buildingScale;
    final gapX = pSize * 5.0 * buildingScale;
    final gapY = pSize * 8.0 * buildingScale;

    for (double y = rect.top + gapY; y < rect.bottom - gapY; y += gapY + winH) {
      for (double x = rect.left + gapX; x < rect.right - gapX - winW; x += gapX + winW) {
        if (_random.nextDouble() > 0.4) {
          final winColor = colorSet.windowOn.withOpacity(0.8);
          canvas.drawRect(Rect.fromLTWH(x, y, winW, winH), Paint()..color = winColor);
          canvas.drawRect(
            Rect.fromLTWH(x - 1, y - 1, winW + 2, winH + 2),
            Paint()..color = winColor.withOpacity(0.1),
          );
        } else {
          canvas.drawRect(Rect.fromLTWH(x, y, winW, winH), Paint()..color = colorSet.windowOff);
        }
      }
    }
  }

  void _drawSpire(Canvas canvas, double topY) {
    final centerX = size.x / 2;
    final spireW = pSize * 2 * buildingScale;
    final spireH = pSize * 15 * buildingScale;
    
    canvas.drawRect(Rect.fromLTWH(centerX - spireW/2, topY - spireH, spireW, spireH), Paint()..color = const Color(0xFFE0E0E0));
    canvas.drawRect(Rect.fromLTWH(centerX - spireW/2, topY - spireH - (pSize * buildingScale), spireW, pSize * buildingScale), Paint()..color = colorSet.neon);
    canvas.drawCircle(Offset(centerX, topY - spireH), pSize * 4 * buildingScale, Paint()..color = colorSet.neon.withOpacity(0.2));
  }
}

class _Section {
  final double wPct;
  final double hPct;
  _Section({required this.wPct, required this.hPct});
}
