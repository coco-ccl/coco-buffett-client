import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'building.dart';
import '../coco_game.dart';
import '../player_bloc/player_bloc.dart';

/// 백화점 문 영역 - 충돌 감지용
class DepartmentStoreDoor extends PositionComponent
    with CollisionCallbacks, HasGameReference<CocoGame> {
  double _cooldown = 0;
  static const double cooldownTime = 1.0; // 1초 쿨다운

  DepartmentStoreDoor({
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_cooldown > 0) {
      _cooldown -= dt;
    }
  }

  // render 메서드 제거 - 디버그용이었음

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    // Player와 충돌 시 shop 진입 (쿨다운이 끝났을 때만)
    if (other.runtimeType.toString() == 'Player' && _cooldown <= 0) {
      // 캐릭터 움직임 멈춤
      game.playerBloc.add(const PlayerEvent.moveStopped());

      // shop 페이지로 이동
      game.onEnterShop?.call();
      _cooldown = cooldownTime;
    }
  }
}

/// 백화점 색상 조합 데이터 클래스
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

/// 백화점 색상 프리셋
class DepartmentColorPresets {
  static const DepartmentColorSet classicShinsegae = DepartmentColorSet(
    stoneBase: Color(0xFF9E9481),
    stoneLit: Color(0xFFE8DCC4),
    windowLit: Color(0xFFFFF9C4),
    roofBorder: Color(0xFFD4AF37),
    outline: Color(0xFF2D2418),
  );

  static const DepartmentColorSet modernWhite = DepartmentColorSet(
    stoneBase: Color(0xFFB0BEC5),
    stoneLit: Color(0xFFECEFF1),
    windowLit: Color(0xFF81D4FA),
    roofBorder: Color(0xFF263238),
    outline: Color(0xFF212121),
  );
}

/// 하이엔드 럭셔리 백화점 (신세계 본점 스타일)
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

  /// 문 영역의 절대 좌표 반환
  Vector2 getDoorPosition() {
    final doorW = pSize * 14 * buildingScale;
    final doorH = pSize * 20 * buildingScale;
    final centerX = size.x / 2;
    return Vector2(
      position.x + centerX - doorW/2,
      position.y - doorH - 4 * buildingScale,
    );
  }

  /// 문 크기 반환
  Vector2 getDoorSize() {
    final doorW = pSize * 14 * buildingScale;
    final doorH = pSize * 20 * buildingScale;
    return Vector2(doorW, doorH);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // 건물 바닥 히트박스 (충돌 방지용)
    add(RectangleHitbox(
      position: Vector2(0, size.y - 10),
      size: Vector2(size.x, 10),
      isSolid: true,
    ));
  }

  @override
  void render(Canvas canvas) {
    _drawBuildingStructure(canvas);
    _drawClassicWindowGroups(canvas);
    _drawCentralFeature(canvas);
    _drawRoofAndLighting(canvas);
    _drawSign(canvas);
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
    final sidePaint = Paint()..color = colorSet.outline.withValues(alpha: 0.4);
    canvas.drawRect(Rect.fromLTWH(size.x, pSize * 4 * buildingScale, sideW, size.y - pSize * 4 * buildingScale), sidePaint);
    
    final linePaint = Paint()..color = colorSet.outline.withValues(alpha: 0.1);
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
        canvas.drawRect(Rect.fromLTWH(x + 1, y + 1, winW, winH), Paint()..color = colorSet.outline.withValues(alpha: 0.5));
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

    canvas.drawRect(featureRect.translate(pSize, 0), Paint()..color = colorSet.outline.withValues(alpha: 0.2));
    canvas.drawRect(featureRect, Paint()..color = colorSet.stoneLit);

    final balconyY = pSize * 42 * buildingScale;
    final balconyR = Rect.fromLTWH(featureRect.left - pSize*4*buildingScale, balconyY, featureRect.width + pSize*8*buildingScale, pSize * 12 * buildingScale);
    canvas.drawRect(balconyR, Paint()..color = colorSet.stoneLit);
    canvas.drawRect(Rect.fromLTWH(balconyR.left, balconyR.top, balconyR.width, pSize * buildingScale), Paint()..color = colorSet.stoneBase);

    final clockY = balconyY + pSize * 22 * buildingScale;
    canvas.drawCircle(Offset(centerX, clockY), pSize * 6 * buildingScale, Paint()..color = colorSet.outline);
    canvas.drawCircle(Offset(centerX, clockY), pSize * 5 * buildingScale, Paint()..color = Colors.white);

    // 시계 바늘 추가
    final now = DateTime.now();
    final hourAngle = (now.hour % 12 + now.minute / 60) * 30 * 3.14159 / 180 - 3.14159 / 2;
    final minuteAngle = (now.minute + now.second / 60) * 6 * 3.14159 / 180 - 3.14159 / 2;

    // 시침 (짧고 두꺼움)
    final hourHandPaint = Paint()
      ..color = colorSet.outline
      ..strokeWidth = pSize * 0.8 * buildingScale
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(centerX, clockY),
      Offset(
        centerX + (pSize * 2.5 * buildingScale) * cos(hourAngle),
        clockY + (pSize * 2.5 * buildingScale) * sin(hourAngle),
      ),
      hourHandPaint,
    );

    // 분침 (길고 얇음)
    final minuteHandPaint = Paint()
      ..color = colorSet.outline
      ..strokeWidth = pSize * 0.5 * buildingScale
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(centerX, clockY),
      Offset(
        centerX + (pSize * 4 * buildingScale) * cos(minuteAngle),
        clockY + (pSize * 4 * buildingScale) * sin(minuteAngle),
      ),
      minuteHandPaint,
    );

    // 중앙 점
    canvas.drawCircle(Offset(centerX, clockY), pSize * 0.8 * buildingScale, Paint()..color = colorSet.outline);

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
        colors: [colorSet.roofBorder.withValues(alpha: 0.15), Colors.transparent],
      ).createShader(Rect.fromLTWH(0, 0, size.x, size.y * 0.3));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y * 0.3), glowPaint);
  }

  void _drawSign(Canvas canvas) {
    final centerX = size.x / 2;
    final doorH = pSize * 20 * buildingScale;
    final signY = size.y - doorH - pSize * 18 * buildingScale;

    // 간판 배경
    final signW = pSize * 24 * buildingScale;
    final signH = pSize * 8 * buildingScale;
    final signRect = Rect.fromLTWH(
      centerX - signW / 2,
      signY,
      signW,
      signH,
    );

    // 간판 그림자
    canvas.drawRect(
      signRect.translate(pSize * buildingScale, pSize * buildingScale),
      Paint()..color = colorSet.outline.withValues(alpha: 0.3),
    );

    // 간판 배경 (우드 느낌)
    canvas.drawRect(
      signRect,
      Paint()..color = const Color(0xFF5D4037),
    );

    // 간판 테두리
    canvas.drawRect(
      signRect,
      Paint()
        ..color = const Color(0xFF3E2723)
        ..style = PaintingStyle.stroke
        ..strokeWidth = pSize * 0.8 * buildingScale,
    );

    // '상점' 텍스트
    final textPainter = TextPainter(
      text: TextSpan(
        text: '상점',
        style: TextStyle(
          color: const Color(0xFFFFF8E1),
          fontSize: pSize * 5 * buildingScale,
          fontWeight: FontWeight.bold,
          letterSpacing: pSize * buildingScale,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        centerX - textPainter.width / 2,
        signY + (signH - textPainter.height) / 2,
      ),
    );
  }
}
