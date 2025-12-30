import 'package:flutter/material.dart';

/// 시간대별 하늘 색상 유틸리티
class SkyColors {
  /// 현재 시간의 하늘 색상 반환
  static ({Color top, Color bottom}) getSkyColors() {
    final now = DateTime.now();
    final hour = now.hour + (now.minute / 60.0);

    Color topColor;
    Color bottomColor;

    if (hour >= 5 && hour < 7) {
      // 새벽
      topColor = const Color(0xFF1A0F21);
      bottomColor = const Color(0xFFE57373);
    } else if (hour >= 7 && hour < 17) {
      // 낮
      topColor = const Color(0xFF4FC3F7);
      bottomColor = const Color(0xFF81D4FA);
    } else if (hour >= 17 && hour < 19) {
      // 노을
      topColor = const Color(0xFF2D1B36);
      bottomColor = const Color(0xFFF4511E);
    } else {
      // 밤
      topColor = const Color(0xFF020205);
      bottomColor = const Color(0xFF0D0D25);
    }

    return (top: topColor, bottom: bottomColor);
  }

  /// 현재 시간의 배경색 반환 (그라디언트 중간 색상)
  static Color getBackgroundColor() {
    final colors = getSkyColors();
    // 그라디언트의 중간 색상 계산 (카메라가 맵 중간을 보므로)
    return Color.lerp(colors.top, colors.bottom, 0.5)!;
  }

  /// 현재 시간의 구름 색상 반환
  static ({Color main, Color shadow}) getCloudColors() {
    final now = DateTime.now();
    final hour = now.hour + (now.minute / 60.0);

    Color mainColor;
    Color shadowColor;

    if (hour >= 7 && hour < 17) {
      // 낮
      mainColor = Colors.white.withValues(alpha: 0.7);
      shadowColor = const Color(0xFFB0BEC5).withValues(alpha: 0.5);
    } else if (hour >= 17 && hour < 19) {
      // 노을
      mainColor = Colors.orangeAccent.withValues(alpha: 0.7);
      shadowColor = Colors.deepOrange.withValues(alpha: 0.5);
    } else {
      // 밤
      mainColor = const Color(0xFF1A1A2E).withValues(alpha: 0.3);
      shadowColor = Colors.black.withValues(alpha: 0.2);
    }

    return (main: mainColor, shadow: shadowColor);
  }
}
