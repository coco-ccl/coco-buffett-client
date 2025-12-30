import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'building.dart';
import '../coco_game.dart';
import '../player_bloc/player_bloc.dart';

/// 증권 거래소 입구 영역 - 충돌 감지용
class StockExchangeDoor extends PositionComponent
    with CollisionCallbacks, HasGameReference<CocoGame> {
  double _cooldown = 0;
  static const double cooldownTime = 1.0; // 1초 쿨다운

  StockExchangeDoor({
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

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    // Player와 충돌 시 stock 진입 (쿨다운이 끝났을 때만)
    if (other.runtimeType.toString() == 'Player' && _cooldown <= 0) {
      // 캐릭터 움직임 멈춤
      game.playerBloc.add(const PlayerEvent.moveStopped());

      // stock 페이지로 이동
      game.onEnterStock?.call();
      _cooldown = cooldownTime;
    }
  }
}

/// 증권 거래소 색상 조합 데이터 클래스
class StockExchangeColorSet {
  final Color marbleBase;
  final Color marbleLit;
  final Color columnBase;
  final Color columnLit;
  final Color pedimentBase;
  final Color bronzeAccent;
  final Color outline;

  const StockExchangeColorSet({
    required this.marbleBase,
    required this.marbleLit,
    required this.columnBase,
    required this.columnLit,
    required this.pedimentBase,
    required this.bronzeAccent,
    required this.outline,
  });
}

/// 증권 거래소 색상 프리셋
class StockExchangeColorPresets {
  static const StockExchangeColorSet classicNYSE = StockExchangeColorSet(
    marbleBase: Color(0xFFD4D4D4),
    marbleLit: Color(0xFFF5F5F5),
    columnBase: Color(0xFFE8E8E8),
    columnLit: Color(0xFFFFFAF0),
    pedimentBase: Color(0xFFB8860B),
    bronzeAccent: Color(0xFFCD7F32),
    outline: Color(0xFF2C2C2C),
  );
}

/// 뉴욕 증권 거래소 스타일 건물
class StockExchange extends Building {
  final StockExchangeColorSet colorSet;
  static const double pSize = 2.0;

  StockExchange({
    required Vector2 position,
    double? width,
    double? height,
    double buildingScale = 1.0,
    this.colorSet = StockExchangeColorPresets.classicNYSE,
  }) : super(
          position: position,
          width: (width ?? 320.0).clamp(200.0, 450.0),
          height: (height ?? 280.0).clamp(180.0, 450.0),
          buildingScale: buildingScale,
        );

  /// 문 영역의 절대 좌표 반환
  Vector2 getDoorPosition() {
    final doorW = pSize * 20 * buildingScale;
    final doorH = pSize * 24 * buildingScale;
    final centerX = size.x / 2;
    return Vector2(
      position.x + centerX - doorW/2,
      position.y - doorH - pSize * 6 * buildingScale,
    );
  }

  /// 문 크기 반환
  Vector2 getDoorSize() {
    final doorW = pSize * 20 * buildingScale;
    final doorH = pSize * 24 * buildingScale;
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
    _drawBuildingBase(canvas);
    _drawPodium(canvas);
    _drawColumns(canvas);
    _drawPediment(canvas);
    _drawStairs(canvas);
    _drawDoor(canvas);
    _drawSign(canvas);
  }

  void _drawBuildingBase(Canvas canvas) {
    // 건물 메인 벽면
    final rect = Rect.fromLTWH(0, pSize * 30 * buildingScale, size.x, size.y - pSize * 30 * buildingScale);
    final facadePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [colorSet.marbleLit, colorSet.marbleBase],
        stops: [0.0, 0.9],
      ).createShader(rect);

    canvas.drawRect(rect, facadePaint);

    // 측면 효과
    final sideW = pSize * 8 * buildingScale;
    final sidePaint = Paint()..color = colorSet.outline.withValues(alpha: 0.3);
    canvas.drawRect(
      Rect.fromLTWH(size.x, pSize * 30 * buildingScale, sideW, size.y - pSize * 30 * buildingScale),
      sidePaint,
    );
  }

  void _drawPodium(Canvas canvas) {
    // 2층 높이의 podium (기단)
    final podiumH = pSize * 20 * buildingScale;
    final podiumRect = Rect.fromLTWH(0, size.y - podiumH, size.x, podiumH);

    final podiumPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [colorSet.marbleBase, colorSet.marbleLit],
      ).createShader(podiumRect);

    canvas.drawRect(podiumRect, podiumPaint);

    // 기단 윤곽선
    canvas.drawLine(
      Offset(0, size.y - podiumH),
      Offset(size.x, size.y - podiumH),
      Paint()
        ..color = colorSet.outline.withValues(alpha: 0.4)
        ..strokeWidth = pSize * 0.5 * buildingScale,
    );
  }

  void _drawColumns(Canvas canvas) {
    // 6개의 코린트식 기둥
    final columnW = pSize * 5 * buildingScale;
    final columnH = pSize * 50 * buildingScale;
    final columnY = size.y - pSize * 70 * buildingScale;
    final totalColumnsW = columnW * 6 + pSize * 5 * 8 * buildingScale; // 기둥 6개 + 간격 5개
    final startX = (size.x - totalColumnsW) / 2;

    for (int i = 0; i < 6; i++) {
      final x = startX + i * (columnW + pSize * 8 * buildingScale);
      _drawSingleColumn(canvas, x, columnY, columnW, columnH);
    }

    // 양쪽 끝 pilasters (평평한 기둥)
    _drawPilaster(canvas, pSize * 8 * buildingScale, columnY, columnW * 0.8, columnH);
    _drawPilaster(canvas, size.x - pSize * 8 * buildingScale - columnW * 0.8, columnY, columnW * 0.8, columnH);

    // Entablature (기둥 위 수평 구조물)
    final entabH = pSize * 8 * buildingScale;
    final entabRect = Rect.fromLTWH(0, columnY - entabH, size.x, entabH);
    canvas.drawRect(entabRect, Paint()..color = colorSet.marbleBase);

    // "NEW YORK STOCK EXCHANGE" 텍스트
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'STOCK EXCHANGE',
        style: TextStyle(
          color: colorSet.outline,
          fontSize: pSize * 3.5 * buildingScale,
          fontWeight: FontWeight.bold,
          letterSpacing: pSize * 0.5 * buildingScale,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (size.x - textPainter.width) / 2,
        columnY - entabH + (entabH - textPainter.height) / 2,
      ),
    );
  }

  void _drawSingleColumn(Canvas canvas, double x, double y, double w, double h) {
    // 기둥 그림자
    canvas.drawRect(
      Rect.fromLTWH(x + pSize * buildingScale, y, w, h),
      Paint()..color = colorSet.outline.withValues(alpha: 0.15),
    );

    // 기둥 본체
    final columnRect = Rect.fromLTWH(x, y, w, h);
    final columnPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [colorSet.columnBase, colorSet.columnLit, colorSet.columnBase],
        stops: [0.0, 0.5, 1.0],
      ).createShader(columnRect);
    canvas.drawRect(columnRect, columnPaint);

    // 플루팅 (세로 홈)
    final flutePaint = Paint()
      ..color = colorSet.outline.withValues(alpha: 0.1)
      ..strokeWidth = pSize * 0.3 * buildingScale;
    for (int i = 1; i < 4; i++) {
      final flutX = x + (w / 4) * i;
      canvas.drawLine(
        Offset(flutX, y + pSize * 2 * buildingScale),
        Offset(flutX, y + h - pSize * 2 * buildingScale),
        flutePaint,
      );
    }

    // 기둥머리 (Capital) - 코린트식
    final capitalH = pSize * 4 * buildingScale;
    canvas.drawRect(
      Rect.fromLTWH(x - pSize * buildingScale, y, w + pSize * 2 * buildingScale, capitalH),
      Paint()..color = colorSet.columnLit,
    );

    // 기둥 베이스
    canvas.drawRect(
      Rect.fromLTWH(x - pSize * 0.5 * buildingScale, y + h - pSize * 2 * buildingScale, w + pSize * buildingScale, pSize * 2 * buildingScale),
      Paint()..color = colorSet.columnBase,
    );
  }

  void _drawPilaster(Canvas canvas, double x, double y, double w, double h) {
    final pilasterRect = Rect.fromLTWH(x, y, w, h);
    final pilasterPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [colorSet.marbleBase, colorSet.columnBase],
      ).createShader(pilasterRect);
    canvas.drawRect(pilasterRect, pilasterPaint);
  }

  void _drawPediment(Canvas canvas) {
    // 삼각형 페디먼트
    final columnY = size.y - pSize * 70 * buildingScale;
    final entabH = pSize * 8 * buildingScale;
    final pedimentTop = columnY - entabH - pSize * 20 * buildingScale;
    final pedimentBottom = columnY - entabH;
    final centerX = size.x / 2;

    final path = Path()
      ..moveTo(centerX, pedimentTop)
      ..lineTo(size.x * 0.15, pedimentBottom)
      ..lineTo(size.x * 0.85, pedimentBottom)
      ..close();

    // 페디먼트 그림자
    canvas.drawPath(
      path.shift(Offset(pSize * buildingScale, pSize * buildingScale)),
      Paint()..color = colorSet.outline.withValues(alpha: 0.2),
    );

    // 페디먼트 본체 (그라디언트로 입체감 표현)
    final pedimentPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [colorSet.pedimentBase, colorSet.pedimentBase.withValues(alpha: 0.7)],
      ).createShader(path.getBounds());
    canvas.drawPath(path, pedimentPaint);

    // 페디먼트 윤곽선
    canvas.drawPath(
      path,
      Paint()
        ..color = colorSet.outline
        ..style = PaintingStyle.stroke
        ..strokeWidth = pSize * 0.8 * buildingScale,
    );
  }

  void _drawStairs(Canvas canvas) {
    // 계단
    final stairW = size.x * 0.6;
    final centerX = size.x / 2;
    final stairStartX = centerX - stairW / 2;
    final numSteps = 5;
    final stepH = pSize * 2 * buildingScale;
    final stairBottom = size.y - pSize * 4 * buildingScale;

    for (int i = 0; i < numSteps; i++) {
      final stepY = stairBottom - (i * stepH);
      final stepRect = Rect.fromLTWH(
        stairStartX,
        stepY,
        stairW,
        stepH,
      );

      canvas.drawRect(
        stepRect,
        Paint()..color = i.isEven ? colorSet.marbleBase : colorSet.marbleLit,
      );

      // 계단 윤곽선
      canvas.drawRect(
        stepRect,
        Paint()
          ..color = colorSet.outline.withValues(alpha: 0.2)
          ..style = PaintingStyle.stroke
          ..strokeWidth = pSize * 0.3 * buildingScale,
      );
    }
  }

  void _drawDoor(Canvas canvas) {
    // 거대한 입구
    final centerX = size.x / 2;
    final doorW = pSize * 20 * buildingScale;
    final doorH = pSize * 24 * buildingScale;
    final doorY = size.y - doorH - pSize * 6 * buildingScale;
    final doorX = centerX - doorW / 2;

    // 문 그림자
    canvas.drawRect(
      Rect.fromLTWH(doorX + pSize * buildingScale, doorY, doorW, doorH),
      Paint()..color = colorSet.outline.withValues(alpha: 0.5),
    );

    // 문 본체
    canvas.drawRect(
      Rect.fromLTWH(doorX, doorY, doorW, doorH),
      Paint()..color = colorSet.outline,
    );

    // 문 디테일 (중앙 분할)
    canvas.drawLine(
      Offset(centerX, doorY),
      Offset(centerX, doorY + doorH),
      Paint()
        ..color = colorSet.bronzeAccent
        ..strokeWidth = pSize * 0.8 * buildingScale,
    );

    // 문 손잡이
    for (double offset in [-pSize * 3 * buildingScale, pSize * 3 * buildingScale]) {
      canvas.drawCircle(
        Offset(centerX + offset, doorY + doorH / 2),
        pSize * 1.2 * buildingScale,
        Paint()..color = colorSet.bronzeAccent,
      );
    }
  }

  void _drawSign(Canvas canvas) {
    final centerX = size.x / 2;
    final doorH = pSize * 24 * buildingScale;
    final signY = size.y - doorH - pSize * 35 * buildingScale;

    // 간판 배경
    final signW = pSize * 28 * buildingScale;
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

    // 간판 배경 (골드 플레이트)
    canvas.drawRect(
      signRect,
      Paint()..color = const Color(0xFFD4AF37),
    );

    // 간판 테두리
    canvas.drawRect(
      signRect,
      Paint()
        ..color = colorSet.bronzeAccent
        ..style = PaintingStyle.stroke
        ..strokeWidth = pSize * 1.2 * buildingScale,
    );

    // '증권 거래소' 텍스트
    final textPainter = TextPainter(
      text: TextSpan(
        text: '증권거래소',
        style: TextStyle(
          color: colorSet.outline,
          fontSize: pSize * 4.5 * buildingScale,
          fontWeight: FontWeight.bold,
          letterSpacing: pSize * 0.3 * buildingScale,
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
