import 'package:flutter/material.dart';
import 'palette.dart';

/// 상의 스프라이트 (32x32 캔버스, row 13-22, 윤곽선 포함)
class TopSprites {
  static const int size = 32;

  static final Map<String, Map<String, dynamic>> designs = {
    'tshirt_white': {'name': '흰색 티셔츠', 'price': 0, 'color': Palette.white},
    'tshirt_blue': {'name': '파란 티셔츠', 'price': 50, 'color': Palette.blue},
    'tshirt_red': {'name': '빨간 티셔츠', 'price': 50, 'color': Palette.red},
    'tshirt_green': {'name': '초록 티셔츠', 'price': 50, 'color': Palette.green},
    'tshirt_flower': {'name': '꽃무늬 티셔츠', 'price': 150, 'color': Palette.white},
    'shirt_white': {'name': '흰색 셔츠', 'price': 100, 'color': Palette.white},
    'suit_black': {'name': '검정 정장', 'price': 500, 'color': Palette.black},
    'suit_navy': {'name': '네이비 정장', 'price': 500, 'color': Palette.navy},
    'suit_gray': {'name': '그레이 정장', 'price': 500, 'color': Palette.gray},
    'tuxedo': {'name': '턱시도', 'price': 1000, 'color': Palette.black},
    'tailcoat': {'name': '연미복', 'price': 1500, 'color': Palette.black},
    'vest_gold': {'name': '금색 조끼', 'price': 800, 'color': Palette.gold},
  };

  static List<List<Color>> getPixels(Direction direction, String topId, [int walkFrame = 0]) {
    final t = Palette.t;
    final o = Palette.outline;
    final data = designs[topId] ?? designs['tshirt_white']!;
    final Color c = data['color'] as Color;

    List<List<Color>> pixels = List.generate(size, (_) => List.filled(size, t));

    String type = topId.split('_')[0];

    if (direction == Direction.down) {
      _drawTopFront(pixels, c, o, type, topId);
    } else if (direction == Direction.up) {
      _drawTopBack(pixels, c, o, type, topId);
    } else if (direction == Direction.left) {
      _drawTopSide(pixels, c, o, type, topId, false, walkFrame);
    } else {
      _drawTopSide(pixels, c, o, type, topId, true, walkFrame);
    }

    return pixels;
  }

  static void _drawTopFront(List<List<Color>> pixels, Color c, Color o, String type, String topId) {
    final w = Palette.white;
    final g = Palette.gold;
    final skin = Palette.skin;

    // 몸통 외곽선 (row 13-21)
    pixels[13][10] = o; pixels[13][21] = o;
    for (int y = 14; y <= 20; y++) {
      pixels[y][9] = o;
      pixels[y][22] = o;
    }
    pixels[21][10] = o; pixels[21][21] = o;

    // 팔 외곽선 (길게 row 14-20)
    for (int y = 14; y <= 20; y++) {
      pixels[y][7] = o;
      pixels[y][24] = o;
    }
    pixels[21][8] = o; pixels[21][23] = o;

    // 몸통 채우기
    for (int y = 13; y <= 21; y++) {
      int startX = (y == 13 || y == 21) ? 11 : 10;
      int endX = (y == 13 || y == 21) ? 20 : 21;
      for (int x = startX; x <= endX; x++) {
        pixels[y][x] = c;
      }
    }

    // 팔 채우기 (길게 row 14-20)
    for (int y = 14; y <= 20; y++) {
      var color = y == 20 ? Palette.skin : c;
      pixels[y][8] = color;
      pixels[y][23] = color;
    }

    // 타입별 디테일
    if (type == 'shirt' || type == 'suit' || type == 'tuxedo' || type == 'tailcoat') {
      // 버튼 라인
      for (int y = 14; y <= 20; y += 2) {
        pixels[y][15] = w;
        pixels[y][16] = w;
      }
    }

    if (type == 'suit' || type == 'tuxedo' || type == 'tailcoat') {
      // 라펠 (옷깃)
      for (int y = 13; y <= 16; y++) {
        pixels[y][12] = o;
        pixels[y][19] = o;
      }
      // 안에 흰 셔츠
      for (int y = 13; y <= 15; y++) {
        for (int x = 14; x <= 17; x++) {
          pixels[y][x] = w;
        }
      }
    }

    if (type == 'tuxedo') {
      // 나비넥타이
      pixels[13][15] = Palette.black;
      pixels[13][16] = Palette.black;
    }

    if (type == 'tailcoat') {
      // 금색 장식
      pixels[14][12] = g; pixels[14][19] = g;
      pixels[16][12] = g; pixels[16][19] = g;
      // 흰 나비넥타이
      pixels[13][15] = w;
      pixels[13][16] = w;
    }

    if (topId == 'vest_gold') {
      // 금색 조끼 - 안에 흰 셔츠 (긴 팔)
      for (int y = 13; y <= 21; y++) {
        pixels[y][10] = w;
        pixels[y][21] = w;
      }
      for (int y = 14; y <= 20; y++) {
        pixels[y][8] = w;
        pixels[y][23] = w;
      }
    }

    if (topId == 'tshirt_flower') {
      // 꽃무늬 - 작은 꽃들을 배치
      // 빨간 꽃
      pixels[15][12] = Palette.red;
      pixels[16][18] = Palette.red;
      pixels[19][14] = Palette.red;

      // 파란 꽃
      pixels[14][16] = Palette.blue;
      pixels[17][13] = Palette.blue;
      pixels[20][19] = Palette.blue;

      // 노란 꽃 (금색)
      pixels[16][15] = g;
      pixels[18][17] = g;
      pixels[19][20] = g;
    }
  }

  static void _drawTopBack(List<List<Color>> pixels, Color c, Color o, String type, String topId) {
    // 뒷모습 외곽선
    pixels[13][10] = o; pixels[13][21] = o;
    for (int y = 14; y <= 20; y++) {
      pixels[y][9] = o;
      pixels[y][22] = o;
    }
    pixels[21][10] = o; pixels[21][21] = o;

    // 팔 외곽선 (길게 row 14-20)
    for (int y = 14; y <= 20; y++) {
      pixels[y][7] = o;
      pixels[y][24] = o;
    }
    pixels[21][8] = o; pixels[21][23] = o;

    // 몸통 채우기
    for (int y = 13; y <= 21; y++) {
      int startX = (y == 13 || y == 21) ? 11 : 10;
      int endX = (y == 13 || y == 21) ? 20 : 21;
      for (int x = startX; x <= endX; x++) {
        pixels[y][x] = c;
      }
    }

    // 팔 채우기 (길게 row 14-20)
    for (int y = 14; y <= 20; y++) {
      var color = y == 20 ? Palette.skin : c;
      pixels[y][8] = color;
      pixels[y][23] = color;
    }

    if (type == 'tailcoat') {
      // 연미복 뒷모습 - 꼬리
      for (int y = 22; y <= 26; y++) {
        pixels[y][11] = c; pixels[y][12] = c;
        pixels[y][19] = c; pixels[y][20] = c;
      }
      // 꼬리 외곽선
      for (int y = 22; y <= 26; y++) {
        pixels[y][10] = o; pixels[y][21] = o;
      }
      pixels[27][11] = o; pixels[27][12] = o;
      pixels[27][19] = o; pixels[27][20] = o;
    }

    if (topId == 'tshirt_flower') {
      final g = Palette.gold;
      // 꽃무늬 뒷면
      pixels[15][11] = Palette.red;
      pixels[17][19] = Palette.red;
      pixels[19][13] = Palette.red;

      pixels[14][15] = Palette.blue;
      pixels[16][20] = Palette.blue;
      pixels[18][12] = Palette.blue;

      pixels[16][13] = g;
      pixels[18][18] = g;
      pixels[20][16] = g;
    }
  }

  static void _drawTopSide(List<List<Color>> pixels, Color c, Color o, String type, String topId, bool flip, int walkFrame) {
    int offset = flip ? 2 : 0;

    // 몸통 외곽선
    pixels[13][11 + offset] = o; pixels[13][18 + offset] = o;
    for (int y = 14; y <= 20; y++) {
      pixels[y][10 + offset] = o;
      pixels[y][19 + offset] = o;
    }
    pixels[21][11 + offset] = o; pixels[21][18 + offset] = o;

    // 팔 외곽선 (길게 row 14-20) - 몸에 붙어있음
    int armOuterX = flip ? 20 + offset : 9 + offset;
    for (int y = 14; y <= 20; y++) {
      pixels[y][armOuterX] = o;
    }
    int armInnerX = flip ? 19 + offset : 10 + offset;
    pixels[21][armInnerX] = o;

    // 몸통 채우기
    for (int y = 13; y <= 21; y++) {
      int startX = (y == 13 || y == 21) ? 12 + offset : 11 + offset;
      int endX = (y == 13 || y == 21) ? 17 + offset : 18 + offset;
      for (int x = startX; x <= endX; x++) {
        pixels[y][x] = c;
      }
    }

    // 팔 채우기 (길게 row 14-20) - 몸에 붙어있음
    int armX = flip ? 19 + offset : 10 + offset;
    for (int y = 14; y <= 20; y++) {
      pixels[y][armX] = c;
    }

    if (type == 'tailcoat' && !flip) {
      // 연미복 옆모습 - 꼬리 (몸통에 고정)
      for (int y = 22; y <= 26; y++) {
        pixels[y][11 + offset] = c;
        pixels[y][10 + offset] = o;
      }
      pixels[27][11 + offset] = o;
    }

    if (topId == 'tshirt_flower') {
      final g = Palette.gold;
      // 꽃무늬 측면 (몸통에 있으므로 걷기 모션 영향 없음)
      pixels[15][13 + offset] = Palette.red;
      pixels[18][15 + offset] = Palette.red;

      pixels[14][15 + offset] = Palette.blue;
      pixels[17][13 + offset] = Palette.blue;

      pixels[16][14 + offset] = g;
      pixels[19][16 + offset] = g;
    }
  }
}
