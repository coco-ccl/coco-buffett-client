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

  static List<List<Color>> getPixels(Direction direction, String bottomId) {
    final t = Palette.t;
    final o = Palette.outline;
    final data = designs[bottomId] ?? designs['pants_black']!;
    final Color c = data['color'] as Color;

    List<List<Color>> pixels = List.generate(size, (_) => List.filled(size, t));

    String type = bottomId.split('_')[0];

    if (direction == Direction.down || direction == Direction.up) {
      _drawBottomFront(pixels, c, o, type);
    } else if (direction == Direction.left) {
      _drawBottomSide(pixels, c, o, type, false);
    } else {
      _drawBottomSide(pixels, c, o, type, true);
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

  static void _drawBottomSide(List<List<Color>> pixels, Color c, Color o, String type, bool flip) {
    int offset = flip ? 2 : 0;

    // 허리 외곽선
    pixels[22][11 + offset] = o;
    pixels[22][18 + offset] = o;

    // 다리 외곽선
    for (int y = 23; y <= 28; y++) {
      pixels[y][12 + offset] = o;
      pixels[y][17 + offset] = o;
    }

    // 허리 채우기
    for (int x = 12 + offset; x <= 17 + offset; x++) {
      pixels[22][x] = c;
    }

    // 다리 채우기
    for (int y = 23; y <= 28; y++) {
      for (int x = 13 + offset; x <= 16 + offset; x++) {
        pixels[y][x] = c;
      }
    }

    // 슬랙스/정장 바지 - 다림질 선
    if (type == 'slacks' || type == 'formal') {
      for (int y = 23; y <= 28; y++) {
        pixels[y][14 + offset] = _darken(c);
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
