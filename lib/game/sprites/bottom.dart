import 'package:flutter/material.dart';
import 'palette.dart';

/// 하의 스프라이트 (32x32 캔버스, row 22-28, 윤곽선 포함)
class BottomSprites {
  static const int size = 32;

  static final Map<String, Map<String, dynamic>> designs = {
    'pants_black': {'name': '검정 바지', 'price': 0, 'color': Palette.pantsBlack},
    'pants_navy': {'name': '네이비 바지', 'price': 100, 'color': Palette.pantsNavy},
    'pants_gray': {'name': '회색 바지', 'price': 100, 'color': Palette.pantsGray},
    'pants_brown': {'name': '갈색 바지', 'price': 100, 'color': Palette.pantsBrown},
    'pants_beige': {'name': '베이지 바지', 'price': 100, 'color': Palette.pantsBeige},
    'jeans_blue': {'name': '청바지', 'price': 150, 'color': Palette.blue},
    'slacks_black': {'name': '검정 슬랙스', 'price': 300, 'color': Palette.pantsBlack},
    'slacks_navy': {'name': '네이비 슬랙스', 'price': 300, 'color': Palette.pantsNavy},
    'slacks_gray': {'name': '그레이 슬랙스', 'price': 300, 'color': Palette.pantsGray},
    'formal_black': {'name': '정장 바지', 'price': 500, 'color': Palette.pantsBlack},
  };

  static List<List<Color>> getPixels(Direction direction, String bottomId, [int walkFrame = 0]) {
    final t = Palette.t;
    final o = Palette.outline;
    final data = designs[bottomId] ?? designs['pants_black']!;
    final Color c = data['color'] as Color;

    List<List<Color>> pixels = List.generate(size, (_) => List.filled(size, t));

    String type = bottomId.split('_')[0];

    if (direction == Direction.down || direction == Direction.up) {
      _drawBottomFront(pixels, c, o, type);
    } else if (direction == Direction.left) {
      _drawBottomSide(pixels, c, o, type, false, walkFrame);
    } else {
      _drawBottomSide(pixels, c, o, type, true, walkFrame);
    }

    return pixels;
  }

  static void _drawBottomFront(List<List<Color>> pixels, Color c, Color o, String type) {
    // 허리 외곽선
    pixels[22][10] = o; pixels[22][21] = o;

    // 왼쪽 다리 외곽선
    for (int y = 23; y <= 28; y++) {
      pixels[y][10] = o;
      pixels[y][15] = o;
    }

    // 오른쪽 다리 외곽선
    for (int y = 23; y <= 28; y++) {
      pixels[y][16] = o;
      pixels[y][21] = o;
    }

    // 허리 채우기
    for (int x = 11; x <= 20; x++) {
      pixels[22][x] = c;
    }

    // 왼쪽 다리 채우기
    for (int y = 23; y <= 28; y++) {
      for (int x = 11; x <= 14; x++) {
        pixels[y][x] = c;
      }
    }

    // 오른쪽 다리 채우기
    for (int y = 23; y <= 28; y++) {
      for (int x = 17; x <= 20; x++) {
        pixels[y][x] = c;
      }
    }

    // 슬랙스/정장 바지 - 다림질 선
    if (type == 'slacks' || type == 'formal') {
      for (int y = 23; y <= 28; y++) {
        pixels[y][12] = _darken(c);
        pixels[y][19] = _darken(c);
      }
    }

    // 청바지 - 스티칭
    if (type == 'jeans') {
      for (int y = 23; y <= 27; y++) {
        pixels[y][14] = Palette.gold;
        pixels[y][17] = Palette.gold;
      }
    }
  }

  static void _drawBottomSide(List<List<Color>> pixels, Color c, Color o, String type, bool flip, int walkFrame) {
    int offset = flip ? 2 : 0;

    // 걷기 모션: 앞다리와 뒷다리 각각 그리기
    int frontLegOffset = 0;
    int backLegOffset = 0;

    if (walkFrame == 1) {
      frontLegOffset = flip ? -2 : 2; // 앞다리 앞으로
      backLegOffset = flip ? 1 : -1;  // 뒷다리 뒤로
    } else if (walkFrame == 2) {
      frontLegOffset = flip ? 1 : -1;  // 앞다리 뒤로
      backLegOffset = flip ? -2 : 2;   // 뒷다리 앞으로
    }

    // 허리는 중앙에 고정
    pixels[22][11 + offset] = o;
    pixels[22][18 + offset] = o;
    for (int x = 12 + offset; x <= 17 + offset; x++) {
      pixels[22][x] = c;
    }

    // 다리 중심 위치 계산 (몸통 중앙)
    int legCenterX = flip ? 15 + offset : 14 + offset;

    // 뒷다리 (먼저 그려서 뒤에 있게) - 몸통 중앙에 위치
    _drawSingleLeg(pixels, c, o, type, legCenterX + backLegOffset);

    // 앞다리 (나중에 그려서 앞에 있게) - 몸통 중앙에 위치
    _drawSingleLeg(pixels, c, o, type, legCenterX + frontLegOffset);
  }

  static void _drawSingleLeg(List<List<Color>> pixels, Color c, Color o, String type, int centerX) {
    // 다리 외곽선 (중심을 기준으로 좌우로, 총 6픽셀 너비)
    int left = centerX - 3;
    int right = centerX + 2;

    for (int y = 23; y <= 28; y++) {
      pixels[y][left] = o;
      pixels[y][right] = o;
    }

    // 다리 채우기 (4픽셀)
    for (int y = 23; y <= 28; y++) {
      for (int x = left + 1; x <= right - 1; x++) {
        pixels[y][x] = c;
      }
    }

    // 슬랙스/정장 바지 - 다림질 선 (중앙)
    if (type == 'slacks' || type == 'formal') {
      for (int y = 23; y <= 28; y++) {
        pixels[y][centerX] = _darken(c);
      }
    }
  }

  static Color _darken(Color c) {
    return Color.fromARGB(
      c.alpha,
      (c.red * 0.7).round(),
      (c.green * 0.7).round(),
      (c.blue * 0.7).round(),
    );
  }
}
