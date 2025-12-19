import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'building.dart';

/// 아파트 빌딩의 색상 조합 데이터 클래스
class ApartmentColorSet {
  final Color wallBase;
  final Color balcony;
  final Color entranceFrame;
  final Color glass;
  final Color roof;

  const ApartmentColorSet({
    required this.wallBase,
    required this.balcony,
    required this.entranceFrame,
    required this.glass,
    required this.roof,
  });
}

/// 아파트 색상 프리셋
class ApartmentColorPresets {
  static const ApartmentColorSet modernDark = ApartmentColorSet(
    wallBase: Color(0xFF37474F),
    balcony: Color(0xFF263238),
    entranceFrame: Color(0xFF455A64),
    glass: Color(0xFF102027),
    roof: Color(0xFF212121),
  );

  static const ApartmentColorSet luxuryBeige = ApartmentColorSet(
    wallBase: Color(0xFFD7CCC8),
    balcony: Color(0xFFBCAAA4),
    entranceFrame: Color(0xFF8D6E63),
    glass: Color(0xFF2D2418),
    roof: Color(0xFF4E342E),
  );

  static const ApartmentColorSet brickRed = ApartmentColorSet(
    wallBase: Color(0xFF8D4433),
    balcony: Color(0xFF5D2E22),
    entranceFrame: Color(0xFF3E1F17),
    glass: Color(0xFF1A0A05),
    roof: Color(0xFF2D140F),
  );
}

class ApartmentBuilding extends Building {
  final math.Random _random = math.Random();
  final int floors;
  final int unitsPerFloor;
  final ApartmentColorSet colorSet;

  static const double pSize = 2.0;
  static const Color colRailing = Color(0xFF90A4AE);
  static const Color colWinOn = Color(0xFFFFF176);
  static const Color colWinCool = Color(0xFFE1F5FE);

  ApartmentBuilding({
    required super.position,
    double? width,
    double? height,
    this.floors = 5,
    this.unitsPerFloor = 3,
    this.colorSet = ApartmentColorPresets.modernDark,
    super.buildingScale = 1.0,
  }) : super(
          width: (width ?? 60.0).clamp(50.0, 120.0),
          height: (height ?? 220.0).clamp(100.0, 500.0),
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
    canvas.drawRect(rect, Paint()..color = colorSet.wallBase);

    _drawApartmentUnits(canvas);
    _drawRoofDetail(canvas);
    _drawMainEntrance(canvas);
  }

  void _drawApartmentUnits(Canvas canvas) {
    final double margin = pSize * 3;
    final double topMargin = pSize * 10;
    final double limitY = size.y - (pSize * 30);
    final double availableH = limitY - topMargin;
    
    final double floorH = availableH / floors;
    final double unitH = floorH * 0.8;
    final double gapY = floorH * 0.2;
    final double unitW = (size.x - (margin * (unitsPerFloor + 1))) / unitsPerFloor;

    for (int f = 0; f < floors; f++) {
      double y = topMargin + f * (unitH + gapY);
      for (int i = 0; i < unitsPerFloor; i++) {
        double x = margin + i * (unitW + margin);
        _drawUnit(canvas, x, y, unitW, unitH);
      }
    }
  }

  void _drawUnit(Canvas canvas, double x, double y, double w, double h) {
    canvas.drawRect(Rect.fromLTWH(x, y, w, h), Paint()..color = colorSet.balcony);

    double winRand = _random.nextDouble();
    if (winRand > 0.4) {
      final winColor = (winRand > 0.8) ? colWinCool : colWinOn;
      const double fixedWinW = pSize * 1.2;
      const double fixedWinH = pSize * 1.2;
      
      canvas.drawRect(
        Rect.fromLTWH(x + pSize, y + pSize, fixedWinW, fixedWinH), 
        Paint()..color = winColor.withOpacity(0.8)
      );
    }

    final railPaint = Paint()..color = colRailing;
    for (double rx = x; rx < x + w; rx += pSize) {
      canvas.drawRect(Rect.fromLTWH(rx, y + h * 0.6, 0.5, h * 0.4), railPaint);
    }
    canvas.drawRect(Rect.fromLTWH(x, y + h * 0.6, w, 0.5), railPaint);
  }

  void _drawRoofDetail(Canvas canvas) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, pSize * 2), Paint()..color = colorSet.roof);
    canvas.drawRect(Rect.fromLTWH(size.x * 0.7, -pSize * 6, pSize * 12, pSize * 6), Paint()..color = colorSet.roof);
  }

  void _drawMainEntrance(Canvas canvas) {
    final entW = pSize * 20;
    final entH = pSize * 12;
    final entX = (size.x - entW) / 2;
    final entY = size.y - entH - pSize;

    canvas.drawRect(Rect.fromLTWH(entX - 1, entY - 1, entW + 2, entH + 2), Paint()..color = colorSet.balcony);
    canvas.drawRect(Rect.fromLTWH(entX, entY, entW, entH), Paint()..color = colorSet.glass);
    canvas.drawRect(
      Rect.fromLTWH(entX, entY, entW, entH),
      Paint()..color = colorSet.entranceFrame..style = PaintingStyle.stroke..strokeWidth = 0.5,
    );
  }
}
