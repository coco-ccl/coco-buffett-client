import 'package:flutter/material.dart';
import 'palette.dart';

/// 신발 스프라이트 (32x32 캔버스, row 29-31, 윤곽선 포함)
class ShoesSprites {
  static const int size = 32;

  static final Map<String, Map<String, dynamic>> designs = {
    'shoes_black': {'name': '검정 구두', 'price': 0, 'color': Palette.shoesBlack},
    'shoes_brown': {'name': '갈색 구두', 'price': 100, 'color': Palette.shoesBrown},
    'sneakers_white': {'name': '흰색 운동화', 'price': 150, 'color': Palette.shoesWhite},
    'sneakers_black': {'name': '검정 운동화', 'price': 150, 'color': Palette.shoesBlack},
    'loafer_black': {'name': '검정 로퍼', 'price': 300, 'color': Palette.shoesBlack},
    'loafer_brown': {'name': '갈색 로퍼', 'price': 300, 'color': Palette.shoesBrown},
    'oxford_black': {'name': '옥스포드 블랙', 'price': 500, 'color': Palette.shoesBlack},
    'oxford_brown': {'name': '옥스포드 브라운', 'price': 500, 'color': Palette.shoesBrown},
    'boots_black': {'name': '검정 부츠', 'price': 400, 'color': Palette.shoesBlack},
  };

  static List<List<Color>> getPixels(Direction direction, String shoesId) {
    final t = Palette.t;
    final o = Palette.outline;
    final data = designs[shoesId] ?? designs['shoes_black']!;
    final Color c = data['color'] as Color;

    List<List<Color>> pixels = List.generate(size, (_) => List.filled(size, t));

    String type = shoesId.split('_')[0];

    if (direction == Direction.down || direction == Direction.up) {
      _drawShoesFront(pixels, c, o, type);
    } else if (direction == Direction.left) {
      _drawShoesSide(pixels, c, o, type, false);
    } else {
      _drawShoesSide(pixels, c, o, type, true);
    }

    return pixels;
  }

  static void _drawShoesFront(List<List<Color>> pixels, Color c, Color o, String type) {
    // 왼쪽 신발 외곽선
    pixels[29][9] = o;
    pixels[29][15] = o;
    for (int x = 9; x <= 15; x++) pixels[31][x] = o;
    pixels[30][8] = o;

    // 오른쪽 신발 외곽선
    pixels[29][16] = o;
    pixels[29][22] = o;
    for (int x = 16; x <= 22; x++) pixels[31][x] = o;
    pixels[30][23] = o;

    // 왼쪽 신발 채우기
    for (int x = 10; x <= 14; x++) {
      pixels[29][x] = c;
      pixels[30][x] = c;
    }
    pixels[30][9] = c;
    pixels[30][15] = c;

    // 오른쪽 신발 채우기
    for (int x = 17; x <= 21; x++) {
      pixels[29][x] = c;
      pixels[30][x] = c;
    }
    pixels[30][16] = c;
    pixels[30][22] = c;

    // 타입별 디테일
    if (type == 'sneakers') {
      // 운동화 - 흰색 밑창
      for (int x = 9; x <= 15; x++) pixels[30][x] = Palette.white;
      for (int x = 16; x <= 22; x++) pixels[30][x] = Palette.white;
    } else if (type == 'oxford' || type == 'loafer') {
      // 구두 광택
      pixels[29][11] = _lighten(c);
      pixels[29][18] = _lighten(c);
    } else if (type == 'boots') {
      // 부츠 - 높이 추가
      for (int x = 11; x <= 14; x++) pixels[28][x] = c;
      for (int x = 17; x <= 20; x++) pixels[28][x] = c;
      pixels[28][10] = o; pixels[28][15] = o;
      pixels[28][16] = o; pixels[28][21] = o;
    }
  }

  static void _drawShoesSide(List<List<Color>> pixels, Color c, Color o, String type, bool flip) {
    int offset = flip ? 2 : 0;

    // 신발 외곽선
    pixels[29][11 + offset] = o;
    pixels[29][19 + offset] = o;
    for (int x = 11 + offset; x <= 19 + offset; x++) pixels[31][x] = o;

    // 앞코/뒷꿈치 외곽선
    int toeOuterX = flip ? 20 + offset : 10 + offset;
    pixels[30][toeOuterX] = o;

    // 신발 채우기
    for (int x = 12 + offset; x <= 18 + offset; x++) {
      pixels[29][x] = c;
      pixels[30][x] = c;
    }
    pixels[30][11 + offset] = c;
    pixels[30][19 + offset] = c;

    // 앞코
    int toeX = flip ? 19 + offset : 11 + offset;
    pixels[30][toeX] = c;

    if (type == 'sneakers') {
      for (int x = 11 + offset; x <= 19 + offset; x++) pixels[30][x] = Palette.white;
      pixels[30][toeX] = Palette.white;
    } else if (type == 'boots') {
      for (int x = 13 + offset; x <= 17 + offset; x++) pixels[28][x] = c;
      pixels[28][12 + offset] = o; pixels[28][18 + offset] = o;
    }
  }

  static Color _lighten(Color c) {
    return Color.fromARGB(
      c.alpha,
      (c.red + (255 - c.red) * 0.3).round().clamp(0, 255),
      (c.green + (255 - c.green) * 0.3).round().clamp(0, 255),
      (c.blue + (255 - c.blue) * 0.3).round().clamp(0, 255),
    );
  }
}
