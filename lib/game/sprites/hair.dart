import 'package:flutter/material.dart';
import 'palette.dart';

/// 헤어스타일 스프라이트 - COCO 스타일 (1:1 비율 둥근 머리)
class HairSprites {
  static const int size = 32;

  static final Map<String, Map<String, dynamic>> designs = {
    'short_brown': {'name': '짧은 갈색', 'price': 0, 'color': Palette.hairBrown},
    'short_black': {'name': '짧은 검정', 'price': 50, 'color': Palette.hairBlack},
    'short_blonde': {'name': '짧은 금발', 'price': 100, 'color': Palette.hairBlonde},
    'long_brown': {'name': '긴 갈색', 'price': 150, 'color': Palette.hairBrown},
    'long_black': {'name': '긴 검정', 'price': 150, 'color': Palette.hairBlack},
    'pomade_black': {'name': '포마드 검정', 'price': 200, 'color': Palette.hairBlack},
    'pomade_brown': {'name': '포마드 갈색', 'price': 200, 'color': Palette.hairBrown},
    'gray': {'name': '회색 머리', 'price': 100, 'color': Palette.hairGray},
  };

  static List<List<Color>> getPixels(Direction direction, String hairId) {
    final t = Palette.t;
    final o = Palette.outline;
    final data = designs[hairId] ?? designs['short_brown']!;
    final Color h = data['color'] as Color;

    List<List<Color>> pixels = List.generate(size, (_) => List.filled(size, t));

    String style = hairId.split('_')[0];

    if (direction == Direction.down) {
      _drawHairFront(pixels, h, o, style);
    } else if (direction == Direction.up) {
      _drawHairBack(pixels, h, o, style);
    } else if (direction == Direction.left) {
      _drawHairSide(pixels, h, o, style, false);
    } else {
      _drawHairSide(pixels, h, o, style, true);
    }

    return pixels;
  }

  static void _drawHairFront(List<List<Color>> pixels, Color h, Color o, String style) {
    // 1:1 비율 머리 (row 0-15, col 8-23 = 16x16)
    // 머리카락 외곽선 (row 0부터 시작)
    for (int x = 12; x <= 19; x++) pixels[0][x] = o;  // row 0: 상단
    pixels[1][10] = o; pixels[1][11] = o;
    pixels[1][20] = o; pixels[1][21] = o;
    pixels[2][9] = o; pixels[2][22] = o;
    pixels[3][8] = o; pixels[3][23] = o;
    pixels[4][7] = o; pixels[4][24] = o;

    // 머리카락 채우기 (풍성하게)
    for (int x = 12; x <= 19; x++) pixels[1][x] = h;
    for (int x = 10; x <= 21; x++) pixels[2][x] = h;
    for (int x = 9; x <= 22; x++) pixels[3][x] = h;
    for (int x = 8; x <= 23; x++) pixels[4][x] = h;

    // row 5-6: 윤곽선 포함
    for (int y = 5; y <= 6; y++) {
      pixels[y][7] = o;
      for (int x = 8; x <= 23; x++) pixels[y][x] = h;
      pixels[y][24] = o;
    }

    // 옆머리 (얼굴 양옆)
    for (int y = 7; y <= 9; y++) {
      pixels[y][7] = o;
      pixels[y][8] = h;
      pixels[y][9] = h;
      pixels[y][22] = h;
      pixels[y][23] = h;
      pixels[y][24] = o;
    }

    if (style == 'long') {
      // 긴 머리 - 더 아래로
      for (int y = 10; y <= 14; y++) {
        pixels[y][7] = o;
        pixels[y][8] = h;
        pixels[y][9] = h;
        pixels[y][22] = h;
        pixels[y][23] = h;
        pixels[y][24] = o;
      }
      pixels[15][8] = o; pixels[15][23] = o;
    } else if (style == 'pomade') {
      // 포마드 - 뒤로 넘김
      pixels[7][7] = o; pixels[7][8] = h;
      pixels[7][23] = h; pixels[7][24] = o;
    } else {
      // 짧은 머리 - 앞머리
      pixels[7][10] = h; pixels[7][11] = h; pixels[7][12] = h;
      pixels[7][19] = h; pixels[7][20] = h; pixels[7][21] = h;
    }
  }

  static void _drawHairBack(List<List<Color>> pixels, Color h, Color o, String style) {
    // 뒷모습 - 머리 전체 덮기 (1:1 비율)
    for (int x = 12; x <= 19; x++) pixels[0][x] = o;
    pixels[1][10] = o; pixels[1][11] = o;
    pixels[1][20] = o; pixels[1][21] = o;
    pixels[2][9] = o; pixels[2][22] = o;
    pixels[3][8] = o; pixels[3][23] = o;
    for (int y = 4; y <= 12; y++) {
      pixels[y][7] = o;
      pixels[y][24] = o;
    }
    pixels[13][8] = o; pixels[13][23] = o;
    pixels[14][9] = o; pixels[14][22] = o;

    // 머리카락 채우기 (전체)
    for (int x = 12; x <= 19; x++) pixels[1][x] = h;
    for (int x = 10; x <= 21; x++) pixels[2][x] = h;
    for (int x = 9; x <= 22; x++) pixels[3][x] = h;
    for (int y = 4; y <= 12; y++) {
      for (int x = 8; x <= 23; x++) {
        pixels[y][x] = h;
      }
    }
    for (int x = 9; x <= 22; x++) pixels[13][x] = h;

    if (style == 'long') {
      // 긴 머리 뒷모습
      for (int y = 14; y <= 17; y++) {
        for (int x = 10; x <= 21; x++) {
          pixels[y][x] = h;
        }
        pixels[y][9] = o;
        pixels[y][22] = o;
      }
      for (int x = 11; x <= 20; x++) pixels[18][x] = o;
    }
  }

  static void _drawHairSide(List<List<Color>> pixels, Color h, Color o, String style, bool flip) {
    int base = flip ? 10 : 9;

    // 측면 - 둥근 머리 (1:1 비율)
    for (int x = base + 3; x <= base + 8; x++) pixels[0][x] = o;
    pixels[1][base + 2] = o; pixels[1][base + 9] = o;
    pixels[2][base + 1] = o; pixels[2][base + 10] = o;
    pixels[3][base] = o; pixels[3][base + 11] = o;
    for (int y = 4; y <= 7; y++) {
      pixels[y][base - 1] = o;
      pixels[y][base + 12] = o;
    }

    // 머리카락 채우기
    for (int x = base + 3; x <= base + 8; x++) pixels[1][x] = h;
    for (int x = base + 2; x <= base + 9; x++) pixels[2][x] = h;
    for (int x = base + 1; x <= base + 10; x++) pixels[3][x] = h;
    for (int y = 4; y <= 7; y++) {
      for (int x = base; x <= base + 11; x++) {
        pixels[y][x] = h;
      }
    }

    if (style == 'long') {
      // 긴 머리 측면
      int outerX = flip ? base + 12 : base - 1;
      for (int y = 8; y <= 14; y++) {
        pixels[y][outerX] = o;
        pixels[y][outerX + (flip ? -1 : 1)] = h;
        pixels[y][outerX + (flip ? -2 : 2)] = h;
      }
      pixels[15][outerX + (flip ? -1 : 1)] = o;
    } else {
      // 짧은 머리/포마드 측면
      int outerX = flip ? base + 12 : base - 1;
      for (int y = 8; y <= 9; y++) {
        pixels[y][outerX] = o;
        pixels[y][outerX + (flip ? -1 : 1)] = h;
      }
    }
  }
}
