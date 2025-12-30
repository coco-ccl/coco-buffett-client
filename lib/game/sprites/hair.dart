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
    // 머리카락 외곽선 (row 0부터 시작, 더 둥글게)
    for (int x = 13; x <= 18; x++) pixels[0][x] = o;  // row 0: 상단 (더 좁게)
    pixels[1][11] = o; pixels[1][12] = o;
    pixels[1][19] = o; pixels[1][20] = o;
    pixels[2][9] = o; pixels[2][22] = o;
    pixels[3][8] = o; pixels[3][23] = o;
    pixels[4][7] = o; pixels[4][24] = o;

    // 머리카락 채우기 (풍성하게, 둥글게)
    for (int x = 13; x <= 18; x++) pixels[1][x] = h;
    for (int x = 10; x <= 21; x++) pixels[2][x] = h;
    for (int x = 9; x <= 22; x++) pixels[3][x] = h;
    for (int x = 8; x <= 23; x++) pixels[4][x] = h;

    // row 5-6: 윤곽선 포함
    for (int y = 5; y <= 6; y++) {
      pixels[y][7] = o;
      for (int x = 8; x <= 23; x++) pixels[y][x] = h;
      pixels[y][24] = o;
    }

    if (style == 'long') {
      // 긴 머리 - 옆머리 풍성하게
      for (int y = 7; y <= 9; y++) {
        pixels[y][7] = o;
        pixels[y][8] = h;
        pixels[y][9] = h;
        pixels[y][22] = h;
        pixels[y][23] = h;
        pixels[y][24] = o;
      }
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
      // 포마드 - 옆머리 얇게
      for (int y = 7; y <= 9; y++) {
        pixels[y][7] = o;
        pixels[y][8] = h;
        pixels[y][9] = h;  // 비어있던 부분 채우기
        pixels[y][22] = h;  // 비어있던 부분 채우기
        pixels[y][23] = h;
        pixels[y][24] = o;
      }
    } else {
      // 짧은 머리 - 옆머리 얇게
      for (int y = 7; y <= 9; y++) {
        pixels[y][7] = o;
        pixels[y][8] = h;
        pixels[y][9] = h;  // 비어있던 부분 채우기
        pixels[y][22] = h;  // 비어있던 부분 채우기
        pixels[y][23] = h;
        pixels[y][24] = o;
      }
      // 짧은 머리 - 앞머리
      pixels[7][10] = h; pixels[7][11] = h; pixels[7][12] = h;
      pixels[7][19] = h; pixels[7][20] = h; pixels[7][21] = h;
    }
  }

  static void _drawHairBack(List<List<Color>> pixels, Color h, Color o, String style) {
    // 뒷모습 - 머리 전체 덮기 (1:1 비율, 더 둥글게)
    for (int x = 13; x <= 18; x++) pixels[0][x] = o;
    pixels[1][11] = o; pixels[1][12] = o;
    pixels[1][19] = o; pixels[1][20] = o;
    pixels[2][9] = o; pixels[2][22] = o;
    pixels[3][8] = o; pixels[3][23] = o;
    for (int y = 4; y <= 12; y++) {
      pixels[y][7] = o;
      pixels[y][24] = o;
    }
    pixels[13][8] = o; pixels[13][23] = o;
    pixels[14][9] = o; pixels[14][22] = o;

    // 머리카락 채우기 (전체, 둥글게)
    for (int x = 13; x <= 18; x++) pixels[1][x] = h;
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
    // 몸통 중심 맞춤: 왼쪽 14.5, 오른쪽 16.5
    // 뒷통수만 둥글게, 앞머리는 직선, 얼굴 면적 13픽셀

    if (flip) {
      // 오른쪽 방향: 얼굴 col 11-22 (12픽셀), 뒷머리 풍성하게
      // Row 0: 두상 상단 (둥글게)
      for (int x = 12; x <= 21; x++) pixels[0][x] = o;

      // Row 1: 더 둥글게 확장
      pixels[1][10] = o;
      for (int x = 11; x <= 22; x++) pixels[1][x] = h;
      pixels[1][23] = o;

      // Row 2-6: 전체 머리 (뒷머리 풍성하게)
      for (int y = 2; y <= 6; y++) {
        pixels[y][9] = o;
        for (int x = 10; x <= 23; x++) pixels[y][x] = h;
        pixels[y][24] = o;
      }

      // 긴 머리
      if (style == 'long') {
        // Row 7-9: 뒷머리
        for (int y = 7; y <= 9; y++) {
          pixels[y][9] = o;
          for (int x = 10; x <= 13; x++) pixels[y][x] = h;
          pixels[y][14] = o;
        }

        // Row 10-12: 뒷통수 좁아짐
        for (int y = 10; y <= 12; y++) {
          pixels[y][9] = o;
          for (int x = 10; x <= 12; x++) pixels[y][x] = h;
          pixels[y][13] = o;
        }

        // Row 13
        pixels[13][10] = o;
        pixels[13][11] = h;
        pixels[13][22] = h;
        pixels[13][23] = o;

        // Row 14-17: 긴 머리
        for (int y = 14; y <= 17; y++) {
          pixels[y][9] = o;
          pixels[y][10] = h;
          pixels[y][11] = h;
          pixels[y][22] = h;
          pixels[y][23] = h;
          pixels[y][24] = o;
        }
        for (int x = 11; x <= 22; x++) pixels[18][x] = o;
      } else {
        // 짧은 머리 - 구렛나루 얇게
        // Row 7-9: 뒷머리 (얇게)
        for (int y = 7; y <= 9; y++) {
          pixels[y][10] = o;
          pixels[y][11] = h;
          pixels[y][12] = o;
        }
      }

    } else {
      // 왼쪽 방향: 얼굴 col 9-20 (12픽셀), 뒷머리 풍성하게
      // Row 0: 두상 상단 (둥글게)
      for (int x = 10; x <= 19; x++) pixels[0][x] = o;

      // Row 1: 더 둥글게 확장
      pixels[1][8] = o;
      for (int x = 9; x <= 20; x++) pixels[1][x] = h;
      pixels[1][21] = o;

      // Row 2-6: 전체 머리 (뒷머리 풍성하게)
      for (int y = 2; y <= 6; y++) {
        pixels[y][7] = o;
        for (int x = 8; x <= 21; x++) pixels[y][x] = h;
        pixels[y][22] = o;
      }

      // 긴 머리
      if (style == 'long') {
        // Row 7-9: 뒷머리
        for (int y = 7; y <= 9; y++) {
          pixels[y][17] = o;
          for (int x = 18; x <= 21; x++) pixels[y][x] = h;
          pixels[y][22] = o;
        }

        // Row 10-12: 뒷통수 좁아짐
        for (int y = 10; y <= 12; y++) {
          pixels[y][18] = o;
          for (int x = 19; x <= 21; x++) pixels[y][x] = h;
          pixels[y][22] = o;
        }

        // Row 13
        pixels[13][9] = o;
        pixels[13][10] = h;
        pixels[13][20] = h;
        pixels[13][21] = o;

        // Row 14-17: 긴 머리
        for (int y = 14; y <= 17; y++) {
          pixels[y][7] = o;
          pixels[y][8] = h;
          pixels[y][9] = h;
          pixels[y][20] = h;
          pixels[y][21] = h;
          pixels[y][22] = o;
        }
        for (int x = 9; x <= 20; x++) pixels[18][x] = o;
      } else {
        // 짧은 머리 - 구렛나루 얇게
        // Row 7-9: 뒷머리 (얇게)
        for (int y = 7; y <= 9; y++) {
          pixels[y][19] = o;
          pixels[y][20] = h;
          pixels[y][21] = o;
        }
      }
    }
  }
}
