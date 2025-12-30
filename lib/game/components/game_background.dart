import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../utils/sky_colors.dart';

/// 게임 전체 배경 (맵 바깥 영역에도 그라디언트 적용)
class GameBackground extends Component {
  GameBackground() {
    priority = -1000; // 가장 뒤에 렌더링
  }

  @override
  void render(Canvas canvas) {
    // 화면 전체에 그라디언트 그리기
    final colors = SkyColors.getSkyColors();

    // 캔버스 전체 영역
    final bounds = canvas.getLocalClipBounds();

    final skyPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [colors.top, colors.bottom],
      ).createShader(bounds);

    canvas.drawRect(bounds, skyPaint);
  }
}
