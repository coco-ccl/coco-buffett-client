import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'building.dart';

class DepartmentColorSet {
  final Color stoneBase;
  final Color stoneLit;
  final Color windowLit;
  final Color roofBorder;
  final Color outline;

  const DepartmentColorSet({
    required this.stoneBase,
    required this.stoneLit,
    required this.windowLit,
    required this.roofBorder,
    required this.outline,
  });
}

class DepartmentColorPresets {
  static const DepartmentColorSet classicShinsegae = DepartmentColorSet(
    stoneBase: Color(0xFF9E9481),
    stoneLit: Color(0xFFE8DCC4),
    windowLit: Color(0xFFFFF9C4),
    roofBorder: Color(0xFFD4AF37),
    outline: Color(0xFF2D2418),
  );
}

class DepartmentStore extends Building {
  final DepartmentColorSet colorSet;
  static const double pSize = 2.0;

  DepartmentStore({
    required Vector2 position,
    double? width,
    double? height,
    double buildingScale = 1.0,
    this.colorSet = DepartmentColorPresets.classicShinsegae,
  }) : super(
          position: position,
          width: (width ?? 280.0).clamp(150.0, 400.0),
          height: (height ?? 240.0).clamp(150.0, 400.0),
          buildingScale: buildingScale,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox(
      position: Vector2(0, size.y - 10),
      size: Vector2(size.x, 10),
    ));
  }

  @override
  void render(Canvas canvas) {
    _drawBuildingStructure(canvas);
    _drawClassicWindowGroups(canvas);
    _drawCentralFeature(canvas);
    _drawRoofAndLighting(canvas);
  }

  void _drawBuildingStructure(Canvas canvas) {
    final rect = size.toRect();
    final facadePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [colorSet.stoneLit, colorSet.stoneBase],
        stops: [0.0, 0.7],
      ).createShader(rect);
    
    canvas.drawRect(rect, facadePaint);

    final sideW = pSize * 6 * buildingScale;
    final sidePaint = Paint()..color = colorSet.outline.withOpacity(0.4);
    canvas.drawRect(Rect.fromLTWH(size.x, pSize * 4 * buildingScale, sideW, size.y - pSize * 4 * buildingScale), sidePaint);
    
    final linePaint = Paint()..color = colorSet.outline.withOpacity(0.1);
    for (double y = pSize * 25 * buildingScale; y < size.y - pSize * 10 * buildingScale; y += pSize * 18 * buildingScale) {
      canvas.drawLine(Offset(0, y), Offset(size.x, y), linePaint);
    }
  }

  void _drawClassicWindowGroups(Canvas canvas) {
    final double winW = pSize * 3.0 * buildingScale;
    final double winH = pSize * 5.0 * buildingScale;
    final double gapY = pSize * 18 * buildingScale;
    
    void drawWindowGroup(double startX, double y) {
      for (int i = 0; i < 3; i++) {
        final x = startX + (i * (winW + pSize * 2 * buildingScale));
        canvas.drawRect(Rect.fromLTWH(x + 1, y + 1, winW, winH), Paint()..color = colorSet.outline.withOpacity(0.5));
        canvas.drawRect(Rect.fromLTWH(x, y, winW, winH), Paint()..color = colorSet.windowLit);
        canvas.drawRect(Rect.fromLTWH(x + winW/2 - 0.5, y, 1, winH), Paint()..color = colorSet.stoneBase);
      }
    }

    for (double y = pSize * 28 * buildingScale; y < size.y - pSize * 40 * buildingScale; y += gapY) {
      drawWindowGroup(pSize * 6 * buildingScale, y);         
      drawWindowGroup(pSize * 30 * buildingScale, y);        
      drawWindowGroup(size.x - pSize*48 * buildingScale, y); 
      drawWindowGroup(size.x - pSize*24 * buildingScale, y); 
    }
  }

  void _drawCentralFeature(Canvas canvas) {
    final centerX = size.x / 2;
    final featureW = size.x * 0.3;
    final featureRect = Rect.fromLTWH(centerX - featureW / 2, pSize * 15 * buildingScale, featureW, size.y - pSize * 15 * buildingScale);

    canvas.drawRect(featureRect.translate(pSize, 0), Paint()..color = colorSet.outline.withOpacity(0.2));
    canvas.drawRect(featureRect, Paint()..color = colorSet.stoneLit);

    final balconyY = pSize * 42 * buildingScale;
    final balconyR = Rect.fromLTWH(featureRect.left - pSize*4*buildingScale, balconyY, featureRect.width + pSize*8*buildingScale, pSize * 12 * buildingScale);
    canvas.drawRect(balconyR, Paint()..color = colorSet.stoneLit);
    canvas.drawRect(Rect.fromLTWH(balconyR.left, balconyR.top, balconyR.width, pSize * buildingScale), Paint()..color = colorSet.stoneBase);

    final clockY = balconyY + pSize * 22 * buildingScale;
    canvas.drawCircle(Offset(centerX, clockY), pSize * 6 * buildingScale, Paint()..color = colorSet.outline);
    canvas.drawCircle(Offset(centerX, clockY), pSize * 5 * buildingScale, Paint()..color = Colors.white);
    
    final doorW = pSize * 14 * buildingScale;
    final doorH = pSize * 20 * buildingScale;
    canvas.drawRect(Rect.fromLTWH(centerX - doorW/2, size.y - doorH - 4 * buildingScale, doorW, doorH), Paint()..color = colorSet.outline);
  }

  void _drawRoofAndLighting(Canvas canvas) {
    final roofRect = Rect.fromLTWH(-pSize*2*buildingScale, pSize*4*buildingScale, size.x + pSize*4*buildingScale, pSize*6*buildingScale);
    canvas.drawRect(roofRect, Paint()..color = colorSet.stoneBase);
    
    final linePaint = Paint()
      ..color = colorSet.roofBorder
      ..style = PaintingStyle.stroke
      ..strokeWidth = pSize * buildingScale;
    canvas.drawLine(Offset(0, pSize*4*buildingScale), Offset(size.x, pSize*4*buildingScale), linePaint);

    final logoX = size.x / 2;
    final logoPaint = Paint()..color = Colors.white;
    for (int i = 0; i < 9; i++) {
      canvas.drawRect(Rect.fromLTWH(logoX - (35 * buildingScale) + (i * 8 * buildingScale), pSize * 8 * buildingScale, 4 * buildingScale, 2 * buildingScale), logoPaint);
    }
    
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [colorSet.roofBorder.withOpacity(0.15), Colors.transparent],
      ).createShader(Rect.fromLTWH(0, 0, size.x, size.y * 0.3));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y * 0.3), glowPaint);
  }
}
