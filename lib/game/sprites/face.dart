import 'package:flutter/material.dart';
import 'palette.dart';

/// 얼굴 스프라이트 - COCO 스타일 (1:1 비율)
/// 전체 머리: row 0-15, col 8-23 (16x16)
/// 얼굴 영역: row 7-15 (머리카락 아래)
class FaceSprites {
  static const int size = 32;

  static final Map<String, Map<String, dynamic>> designs = {
    'default': {'name': '기본 얼굴', 'price': 0},
    'cute': {'name': '귀여운 얼굴', 'price': 100},
    'cool': {'name': '시크한 얼굴', 'price': 150},
  };

  static List<List<Color>> getPixels(Direction direction, String faceId) {
    final t = Palette.t;
    final s = Palette.skin;
    final o = Palette.outline;
    final e = Palette.eye;
    final b = Palette.blush;
    final m = Palette.mouth;

    List<List<Color>> pixels = List.generate(size, (_) => List.filled(size, t));

    if (direction == Direction.down) {
      _drawFaceFront(pixels, s, o);
      _drawFeatures(pixels, e, b, m, faceId);
    } else if (direction == Direction.up) {
      _drawFaceBack(pixels, s, o);
    } else if (direction == Direction.left) {
      _drawFaceSide(pixels, s, o, e, b, m, faceId, false);
    } else {
      _drawFaceSide(pixels, s, o, e, b, m, faceId, true);
    }

    return pixels;
  }

  // 정면 얼굴 (머리카락 아래 영역) - 둥근 U라인 턱
  static void _drawFaceFront(List<List<Color>> pixels, Color s, Color o) {
    // 얼굴 영역: row 7-15, 머리카락이 row 0-6 + 옆머리
    // row 7-9: 머리카락 옆에 얼굴 (좁은 상단)
    for (int y = 7; y <= 9; y++) {
      for (int x = 10; x <= 21; x++) {
        pixels[y][x] = s;
      }
    }
    // row 10-11: 가장 넓은 얼굴 (볼 부분)
    for (int y = 10; y <= 11; y++) {
      pixels[y][8] = o;
      pixels[y][23] = o;
      for (int x = 9; x <= 22; x++) {
        pixels[y][x] = s;
      }
    }
    // row 12: 살짝 좁아지기 시작
    pixels[12][8] = o; pixels[12][23] = o;
    for (int x = 9; x <= 22; x++) pixels[12][x] = s;

    // row 13: U라인 시작 - 부드럽게 좁아짐
    pixels[13][9] = o; pixels[13][22] = o;
    for (int x = 10; x <= 21; x++) pixels[13][x] = s;

    // row 14: 턱 - 더 좁아짐
    pixels[14][10] = o; pixels[14][21] = o;
    for (int x = 11; x <= 20; x++) pixels[14][x] = s;

    // row 15: 턱 끝 - 둥근 U라인 마무리
    pixels[15][12] = o; pixels[15][19] = o;
    for (int x = 13; x <= 18; x++) pixels[15][x] = s;

    // row 16: 턱 끝점 (살짝 V느낌)
    for (int x = 14; x <= 17; x++) pixels[16][x] = o;
  }

  static void _drawFeatures(List<List<Color>> pixels, Color e, Color b, Color m, String faceId) {
    switch (faceId) {
      case 'cute':
        // 큰 눈 (2x2)
        pixels[9][11] = e; pixels[9][12] = e;
        pixels[10][11] = e; pixels[10][12] = e;
        pixels[9][19] = e; pixels[9][20] = e;
        pixels[10][19] = e; pixels[10][20] = e;
        // 볼터치
        pixels[11][10] = b; pixels[11][21] = b;
        // 미소
        pixels[12][14] = m; pixels[12][17] = m;
        pixels[13][15] = m; pixels[13][16] = m;
        break;
      case 'cool':
        // 날카로운 눈
        for (int x = 11; x <= 13; x++) pixels[10][x] = e;
        for (int x = 18; x <= 20; x++) pixels[10][x] = e;
        // 일자 입
        for (int x = 14; x <= 17; x++) pixels[12][x] = m;
        break;
      default:
        // 기본 눈 (2x1 세로)
        pixels[9][12] = e; pixels[10][12] = e;
        pixels[9][19] = e; pixels[10][19] = e;
        // 볼터치
        pixels[11][10] = b; pixels[11][21] = b;
        // 미소
        pixels[12][14] = m; pixels[12][17] = m;
        pixels[13][15] = m; pixels[13][16] = m;
    }
  }

  // 뒷면 (머리카락으로 대부분 덮임) - U라인 턱
  static void _drawFaceBack(List<List<Color>> pixels, Color s, Color o) {
    // 목/귀 부분만 보임 - U라인 맞춤
    pixels[13][9] = o; pixels[13][22] = o;
    for (int x = 10; x <= 21; x++) pixels[13][x] = s;

    pixels[14][10] = o; pixels[14][21] = o;
    for (int x = 11; x <= 20; x++) pixels[14][x] = s;

    pixels[15][12] = o; pixels[15][19] = o;
    for (int x = 13; x <= 18; x++) pixels[15][x] = s;

    for (int x = 14; x <= 17; x++) pixels[16][x] = o;
  }

  // 측면 - 개선된 옆모습 (단순하고 귀여운 디자인)
  static void _drawFaceSide(List<List<Color>> pixels, Color s, Color o, Color e, Color b, Color m, String faceId, bool flip) {
    // 얼굴 면적을 앞모습만큼 크게: 16픽셀
    // 왼쪽: col 7-22, 오른쪽: col 9-24
    int base = flip ? 9 : 7;

    // Row 7-10: 이마~코 부분 (넓은 얼굴 영역, 대칭)
    for (int y = 7; y <= 10; y++) {
      if (flip) {
        // 오른쪽: col 11-22 (12픽셀, 중심 16.5) + 외곽선 col 23
        for (int x = 11; x <= 22; x++) pixels[y][x] = s;
        pixels[y][23] = o;
      } else {
        // 왼쪽: 외곽선 col 8 + col 9-20 (12픽셀, 중심 14.5)
        pixels[y][8] = o;
        for (int x = 9; x <= 20; x++) pixels[y][x] = s;
      }
    }

    // 코: 얼굴 앞쪽에 작은 점 (row 10)
    if (flip) {
      pixels[10][22] = o;
    } else {
      pixels[10][9] = o;
    }

    // Row 11: 볼 부분 (귀 없이)
    if (flip) {
      for (int x = 11; x <= 22; x++) pixels[11][x] = s;
      pixels[11][23] = o;
    } else {
      pixels[11][8] = o;
      for (int x = 9; x <= 20; x++) pixels[11][x] = s;
    }

    // Row 12: 입 부분 (살짝 좁아짐)
    pixels[12][base + 2] = o;
    pixels[12][base + 13] = o;
    for (int x = base + 3; x <= base + 12; x++) pixels[12][x] = s;

    // Row 13: 턱 (더 좁아짐)
    pixels[13][base + 4] = o;
    pixels[13][base + 11] = o;
    for (int x = base + 5; x <= base + 10; x++) pixels[13][x] = s;

    // Row 14: 턱 끝
    pixels[14][base + 6] = o;
    pixels[14][base + 7] = o;
    pixels[14][base + 8] = o;
    pixels[14][base + 9] = o;

    // 눈 (한쪽만, 2픽셀)
    int eyeX = flip ? 19 : 12;
    pixels[9][eyeX] = e;
    pixels[10][eyeX] = e;

    // 볼터치
    int blushX = flip ? 20 : 11;
    pixels[11][blushX] = b;

    // 입 (작게, 1픽셀)
    int mouthX = flip ? base + 8 : base + 7;
    pixels[12][mouthX] = m;
  }
}
