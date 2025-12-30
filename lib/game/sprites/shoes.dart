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

  static List<List<Color>> getPixels(Direction direction, String shoesId, [int walkFrame = 0]) {
    final t = Palette.t;
    final o = Palette.outline;
    final data = designs[shoesId] ?? designs['shoes_black']!;
    final Color c = data['color'] as Color;

    List<List<Color>> pixels = List.generate(size, (_) => List.filled(size, t));

    String type = shoesId.split('_')[0];

    if (direction == Direction.down || direction == Direction.up) {
      _drawShoesFront(pixels, c, o, type, walkFrame);
    } else if (direction == Direction.left) {
      _drawShoesSide(pixels, c, o, type, false, walkFrame);
    } else {
      _drawShoesSide(pixels, c, o, type, true, walkFrame);
    }

    return pixels;
  }

  static void _drawShoesFront(List<List<Color>> pixels, Color c, Color o, String type, int walkFrame) {
    // walkFrame 0: idle, 1: 왼발 들기, 2: 오른발 들기
    int leftYOffset = 0;
    int rightYOffset = 0;
    if (walkFrame == 1) {
      leftYOffset = -1; // 왼발 1픽셀 위로
    } else if (walkFrame == 2) {
      rightYOffset = -1; // 오른발 1픽셀 위로
    }

    // 왼쪽 신발 외곽선
    pixels[29 + leftYOffset][9] = o;
    pixels[29 + leftYOffset][15] = o;
    for (int x = 9; x <= 15; x++) pixels[31 + leftYOffset][x] = o;
    pixels[30 + leftYOffset][8] = o;

    // 오른쪽 신발 외곽선
    pixels[29 + rightYOffset][16] = o;
    pixels[29 + rightYOffset][22] = o;
    for (int x = 16; x <= 22; x++) pixels[31 + rightYOffset][x] = o;
    pixels[30 + rightYOffset][23] = o;

    // 왼쪽 신발 채우기
    for (int x = 10; x <= 14; x++) {
      pixels[29 + leftYOffset][x] = c;
      pixels[30 + leftYOffset][x] = c;
    }
    pixels[30 + leftYOffset][9] = c;
    pixels[30 + leftYOffset][15] = c;

    // 오른쪽 신발 채우기
    for (int x = 17; x <= 21; x++) {
      pixels[29 + rightYOffset][x] = c;
      pixels[30 + rightYOffset][x] = c;
    }
    pixels[30 + rightYOffset][16] = c;
    pixels[30 + rightYOffset][22] = c;

    // 타입별 디테일
    if (type == 'sneakers') {
      // 운동화 - 흰색 밑창
      for (int x = 9; x <= 15; x++) pixels[30 + leftYOffset][x] = Palette.white;
      for (int x = 16; x <= 22; x++) pixels[30 + rightYOffset][x] = Palette.white;
    } else if (type == 'oxford' || type == 'loafer') {
      // 구두 광택
      pixels[29 + leftYOffset][11] = _lighten(c);
      pixels[29 + rightYOffset][18] = _lighten(c);
    } else if (type == 'boots') {
      // 부츠 - 높이 추가
      for (int x = 11; x <= 14; x++) pixels[28 + leftYOffset][x] = c;
      for (int x = 17; x <= 20; x++) pixels[28 + rightYOffset][x] = c;
      pixels[28 + leftYOffset][10] = o; pixels[28 + leftYOffset][15] = o;
      pixels[28 + rightYOffset][16] = o; pixels[28 + rightYOffset][21] = o;
    }
  }

  static void _drawShoesSide(List<List<Color>> pixels, Color c, Color o, String type, bool flip, int walkFrame) {
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

    // 신발 중심 위치 계산 (바지 다리와 동일)
    int shoeCenterX = flip ? 15 + offset : 14 + offset;

    // 뒷다리 신발 (먼저 그려서 뒤에 있게) - 바지 다리와 중심 맞춤
    _drawSingleShoe(pixels, c, o, type, shoeCenterX + backLegOffset, flip);

    // 앞다리 신발 (나중에 그려서 앞에 있게) - 바지 다리와 중심 맞춤
    _drawSingleShoe(pixels, c, o, type, shoeCenterX + frontLegOffset, flip);
  }

  static void _drawSingleShoe(List<List<Color>> pixels, Color c, Color o, String type, int centerX, bool flip) {
    // 신발 측면 뷰 - 진행 방향에 따라 앞코 위치가 달라짐
    // flip = false (왼쪽 방향): 왼쪽이 앞코, 오른쪽이 뒤꿈치
    // flip = true (오른쪽 방향): 오른쪽이 앞코, 왼쪽이 뒤꿈치

    if (flip) {
      // 오른쪽 방향: 오른쪽이 앞코
      int heel = centerX - 3;    // 뒤꿈치 (왼쪽)
      int toe = centerX + 3;     // 앞코 (오른쪽)

      // 신발 윗부분 외곽선 (row 29)
      pixels[29][heel] = o;
      pixels[29][toe] = o;

      // 신발 윗부분 채우기 (row 29)
      for (int x = heel + 1; x <= toe - 1; x++) pixels[29][x] = c;

      // 신발 중간 (row 30)
      pixels[30][heel] = o;
      for (int x = heel + 1; x <= toe; x++) pixels[30][x] = c;
      pixels[30][toe + 1] = o; // 앞코 돌출

      // 밑창 (row 31)
      for (int x = heel; x <= toe + 1; x++) pixels[31][x] = o;

      // 타입별 디테일
      if (type == 'sneakers') {
        for (int x = heel + 1; x <= toe; x++) pixels[30][x] = Palette.white;
      } else if (type == 'oxford' || type == 'loafer') {
        pixels[29][toe - 1] = _lighten(c);
      } else if (type == 'boots') {
        for (int x = heel + 1; x <= toe - 1; x++) pixels[28][x] = c;
        pixels[28][heel] = o;
        pixels[28][toe] = o;
      }
    } else {
      // 왼쪽 방향: 왼쪽이 앞코
      int toe = centerX - 3;     // 앞코 (왼쪽)
      int heel = centerX + 3;    // 뒤꿈치 (오른쪽)

      // 신발 윗부분 외곽선 (row 29)
      pixels[29][toe] = o;
      pixels[29][heel] = o;

      // 신발 윗부분 채우기 (row 29)
      for (int x = toe + 1; x <= heel - 1; x++) pixels[29][x] = c;

      // 신발 중간 (row 30)
      pixels[30][toe - 1] = o; // 앞코 돌출
      for (int x = toe; x <= heel - 1; x++) pixels[30][x] = c;
      pixels[30][heel] = o;

      // 밑창 (row 31)
      for (int x = toe - 1; x <= heel; x++) pixels[31][x] = o;

      // 타입별 디테일
      if (type == 'sneakers') {
        for (int x = toe; x <= heel - 1; x++) pixels[30][x] = Palette.white;
      } else if (type == 'oxford' || type == 'loafer') {
        pixels[29][toe + 1] = _lighten(c);
      } else if (type == 'boots') {
        for (int x = toe + 1; x <= heel - 1; x++) pixels[28][x] = c;
        pixels[28][toe] = o;
        pixels[28][heel] = o;
      }
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
