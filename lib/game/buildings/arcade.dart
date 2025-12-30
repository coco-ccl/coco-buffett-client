import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'building.dart';
import '../coco_game.dart';
import '../player_bloc/player_bloc.dart';

/// 오락실 문 영역 - 충돌 감지용
class ArcadeDoor extends PositionComponent
    with CollisionCallbacks, HasGameReference<CocoGame> {
  double _cooldown = 0;
  static const double cooldownTime = 1.0; // 1초 쿨다운

  ArcadeDoor({
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

    // Player와 충돌 시 minigame 진입 (쿨다운이 끝났을 때만)
    if (other.runtimeType.toString() == 'Player' && _cooldown <= 0) {
      // 캐릭터 움직임 멈춤
      game.playerBloc.add(const PlayerEvent.moveStopped());

      // minigame 페이지로 이동
      game.onEnterArcade?.call();
      _cooldown = cooldownTime;
    }
  }
}

/// 오락실 색상 조합 데이터 클래스
class ArcadeColorSet {
  final Color wallBase;
  final Color wallAccent;
  final Color neonPink;
  final Color neonBlue;
  final Color windowGlow;
  final Color outline;

  const ArcadeColorSet({
    required this.wallBase,
    required this.wallAccent,
    required this.neonPink,
    required this.neonBlue,
    required this.windowGlow,
    required this.outline,
  });
}

/// 오락실 색상 프리셋
class ArcadeColorPresets {
  static const ArcadeColorSet classic = ArcadeColorSet(
    wallBase: Color(0xFF1A1A2E),
    wallAccent: Color(0xFF16213E),
    neonPink: Color(0xFFFF00FF),
    neonBlue: Color(0xFF00FFFF),
    windowGlow: Color(0xFFFFD700),
    outline: Color(0xFF0A0A14),
  );
}

/// 레트로 오락실 (네온 사인 스타일)
class Arcade extends Building {
  final ArcadeColorSet colorSet;
  static const double pSize = 2.0;
  double _time = 0;

  Arcade({
    required Vector2 position,
    double? width,
    double? height,
    double buildingScale = 1.0,
    this.colorSet = ArcadeColorPresets.classic,
  }) : super(
          position: position,
          width: (width ?? 200.0).clamp(120.0, 300.0),
          height: (height ?? 180.0).clamp(120.0, 300.0),
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
  void update(double dt) {
    super.update(dt);
    _time += dt;
  }

  @override
  void render(Canvas canvas) {
    _drawBuildingStructure(canvas);
    _drawWindows(canvas);
    _drawDoor(canvas);
    _drawNeonSign(canvas);
    _drawDecorations(canvas);
  }

  void _drawBuildingStructure(Canvas canvas) {
    final rect = size.toRect();

    // 메인 벽 그라디언트
    final facadePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [colorSet.wallAccent, colorSet.wallBase],
        stops: [0.0, 0.8],
      ).createShader(rect);

    canvas.drawRect(rect, facadePaint);

    // 외곽선
    canvas.drawRect(
      rect,
      Paint()
        ..color = colorSet.outline
        ..style = PaintingStyle.stroke
        ..strokeWidth = pSize * 0.5 * buildingScale,
    );

    // 사이드 패널 (3D 효과)
    final sideW = pSize * 4 * buildingScale;
    final sidePaint = Paint()..color = colorSet.outline.withValues(alpha: 0.5);
    canvas.drawRect(
      Rect.fromLTWH(size.x, pSize * 6 * buildingScale, sideW, size.y - pSize * 6 * buildingScale),
      sidePaint,
    );

    // 수평 라인 (층 구분)
    final linePaint = Paint()
      ..color = colorSet.neonBlue.withValues(alpha: 0.2)
      ..strokeWidth = pSize * 0.3 * buildingScale;

    canvas.drawLine(
      Offset(0, size.y * 0.3),
      Offset(size.x, size.y * 0.3),
      linePaint,
    );
  }

  void _drawWindows(Canvas canvas) {
    final double winW = pSize * 5.0 * buildingScale;
    final double winH = pSize * 6.0 * buildingScale;

    // 상단 창문들 (게임기 화면처럼 빛나는 효과)
    final windowY = pSize * 15 * buildingScale;

    for (int i = 0; i < 3; i++) {
      final x = pSize * (12 + i * 18) * buildingScale;

      // 창문 글로우
      final glowPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            colorSet.windowGlow.withValues(alpha: 0.3),
            Colors.transparent,
          ],
        ).createShader(Rect.fromLTWH(x - 2, windowY - 2, winW + 4, winH + 4));
      canvas.drawRect(Rect.fromLTWH(x - 2, windowY - 2, winW + 4, winH + 4), glowPaint);

      // 창문 그림자
      canvas.drawRect(
        Rect.fromLTWH(x + 1, windowY + 1, winW, winH),
        Paint()..color = colorSet.outline,
      );

      // 창문 메인 (시간에 따라 색 변화)
      final windowColor = Color.lerp(
        colorSet.neonBlue,
        colorSet.neonPink,
        (sin(_time * 2 + i) + 1) / 2,
      )!;
      canvas.drawRect(
        Rect.fromLTWH(x, windowY, winW, winH),
        Paint()..color = windowColor.withValues(alpha: 0.7),
      );

      // 창문 하이라이트
      canvas.drawRect(
        Rect.fromLTWH(x + pSize * 0.5 * buildingScale, windowY + pSize * 0.5 * buildingScale, winW * 0.3, winH * 0.3),
        Paint()..color = Colors.white.withValues(alpha: 0.5),
      );
    }
  }

  void _drawDoor(Canvas canvas) {
    final centerX = size.x / 2;
    final doorW = pSize * 14 * buildingScale;
    final doorH = pSize * 20 * buildingScale;
    final doorX = centerX - doorW / 2;
    final doorY = size.y - doorH - 4 * buildingScale;

    // 문 글로우 효과
    final glowPaint = Paint()
      ..shader = RadialGradient(
        center: Alignment.center,
        colors: [
          colorSet.neonPink.withValues(alpha: 0.3),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(doorX - 4, doorY - 4, doorW + 8, doorH + 8));
    canvas.drawRect(Rect.fromLTWH(doorX - 4, doorY - 4, doorW + 8, doorH + 8), glowPaint);

    // 문 그림자
    canvas.drawRect(
      Rect.fromLTWH(doorX + pSize * buildingScale, doorY + pSize * buildingScale, doorW, doorH),
      Paint()..color = colorSet.outline,
    );

    // 문 메인
    canvas.drawRect(
      Rect.fromLTWH(doorX, doorY, doorW, doorH),
      Paint()..color = const Color(0xFF2D2D44),
    );

    // 문 테두리 (네온)
    final doorBorderPaint = Paint()
      ..color = colorSet.neonBlue.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = pSize * 0.8 * buildingScale;
    canvas.drawRect(Rect.fromLTWH(doorX, doorY, doorW, doorH), doorBorderPaint);

    // 문 손잡이
    canvas.drawCircle(
      Offset(doorX + doorW * 0.7, doorY + doorH * 0.5),
      pSize * 1.5 * buildingScale,
      Paint()..color = colorSet.windowGlow,
    );
  }

  void _drawNeonSign(Canvas canvas) {
    final centerX = size.x / 2;
    final signY = pSize * 8 * buildingScale;

    // 간판 배경 (어두운 패널)
    final signW = pSize * 30 * buildingScale;
    final signH = pSize * 10 * buildingScale;
    final signRect = Rect.fromLTWH(
      centerX - signW / 2,
      signY,
      signW,
      signH,
    );

    // 배경 패널
    canvas.drawRect(
      signRect,
      Paint()..color = colorSet.wallAccent,
    );

    // 네온 테두리 (깜빡이는 효과)
    final blinkAlpha = (sin(_time * 3) * 0.3 + 0.7);
    final neonBorderPaint = Paint()
      ..color = colorSet.neonPink.withValues(alpha: blinkAlpha)
      ..style = PaintingStyle.stroke
      ..strokeWidth = pSize * 1.2 * buildingScale;
    canvas.drawRect(signRect, neonBorderPaint);

    // 간판 글로우
    final signGlowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          colorSet.neonPink.withValues(alpha: 0.4 * blinkAlpha),
          Colors.transparent,
        ],
      ).createShader(signRect.inflate(pSize * 4 * buildingScale));
    canvas.drawRect(signRect.inflate(pSize * 4 * buildingScale), signGlowPaint);

    // '게임' 텍스트 (네온 스타일)
    final textPainter = TextPainter(
      text: TextSpan(
        text: '게임',
        style: TextStyle(
          color: colorSet.neonPink,
          fontSize: pSize * 6 * buildingScale,
          fontWeight: FontWeight.w900,
          letterSpacing: pSize * 2 * buildingScale,
          shadows: [
            Shadow(
              color: colorSet.neonPink.withValues(alpha: 0.8),
              blurRadius: pSize * 3 * buildingScale,
            ),
            Shadow(
              color: Colors.white,
              blurRadius: pSize * buildingScale,
            ),
          ],
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

  void _drawDecorations(Canvas canvas) {
    // 하단 네온 스트립
    final stripY = size.y - pSize * 28 * buildingScale;
    final stripAlpha = (sin(_time * 4) * 0.3 + 0.7);

    for (int i = 0; i < 5; i++) {
      final x = pSize * (8 + i * 12) * buildingScale;
      final color = i % 2 == 0 ? colorSet.neonBlue : colorSet.neonPink;

      canvas.drawRect(
        Rect.fromLTWH(x, stripY, pSize * 8 * buildingScale, pSize * 2 * buildingScale),
        Paint()..color = color.withValues(alpha: stripAlpha),
      );
    }

    // 픽셀 장식 (게임 아이콘 느낌)
    final pixelSize = pSize * 2 * buildingScale;
    final decorY = size.y * 0.35;

    // 왼쪽 상단 픽셀 장식
    _drawPixelIcon(canvas, pSize * 8 * buildingScale, decorY, pixelSize, colorSet.neonBlue);

    // 오른쪽 상단 픽셀 장식
    _drawPixelIcon(canvas, size.x - pSize * 14 * buildingScale, decorY, pixelSize, colorSet.neonPink);
  }

  void _drawPixelIcon(Canvas canvas, double x, double y, double pixelSize, Color color) {
    // 간단한 스페이스 인베이더 스타일 아이콘
    final pattern = [
      [0, 1, 0],
      [1, 1, 1],
      [1, 0, 1],
    ];

    for (int row = 0; row < pattern.length; row++) {
      for (int col = 0; col < pattern[row].length; col++) {
        if (pattern[row][col] == 1) {
          canvas.drawRect(
            Rect.fromLTWH(
              x + col * pixelSize,
              y + row * pixelSize,
              pixelSize,
              pixelSize,
            ),
            Paint()..color = color.withValues(alpha: 0.6),
          );
        }
      }
    }
  }
}
