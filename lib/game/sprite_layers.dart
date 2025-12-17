import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'sprites/palette.dart';
import 'sprites/face.dart';
import 'sprites/hair.dart';
import 'sprites/top.dart';
import 'sprites/bottom.dart';
import 'sprites/shoes.dart';

export 'sprites/palette.dart' show Direction;

/// 레이어별 픽셀 데이터 생성기 - 32x32 COCO 스타일
/// 각 파트가 자체 윤곽선을 포함
class SpriteLayerGenerator {
  static const int pixelSize = 32;

  /// 레이어들을 합쳐서 하나의 이미지로 생성
  static Future<ui.Image> generateLayeredImage({
    required Direction direction,
    required String faceId,
    required String hairId,
    required String topId,
    required String bottomId,
    required String shoesId,
  }) async {
    final facePixels = FaceSprites.getPixels(direction, faceId);
    final hairPixels = HairSprites.getPixels(direction, hairId);
    final topPixels = TopSprites.getPixels(direction, topId);
    final bottomPixels = BottomSprites.getPixels(direction, bottomId);
    final shoesPixels = ShoesSprites.getPixels(direction, shoesId);

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    // 레이어 순서: 뒤에서 앞으로 그리기
    // 상의 → 하의 → 신발 → 얼굴 → 머리카락 (각 파트가 자체 윤곽선 포함)
    _drawPixels(canvas, topPixels);
    _drawPixels(canvas, bottomPixels);
    _drawPixels(canvas, shoesPixels);
    _drawPixels(canvas, facePixels);
    _drawPixels(canvas, hairPixels);

    final picture = recorder.endRecording();
    return await picture.toImage(pixelSize, pixelSize);
  }

  static void _drawPixels(Canvas canvas, List<List<Color>> pixels) {
    for (int y = 0; y < pixelSize; y++) {
      for (int x = 0; x < pixelSize; x++) {
        final color = pixels[y][x];
        if (color.alpha > 0) {
          final paint = Paint()..color = color;
          canvas.drawRect(
            Rect.fromLTWH(x.toDouble(), y.toDouble(), 1, 1),
            paint,
          );
        }
      }
    }
  }

  /// 모든 방향의 레이어드 이미지 생성
  static Future<Map<Direction, ui.Image>> generateAllDirections({
    required String faceId,
    required String hairId,
    required String topId,
    required String bottomId,
    required String shoesId,
  }) async {
    final images = <Direction, ui.Image>{};
    for (final direction in Direction.values) {
      images[direction] = await generateLayeredImage(
        direction: direction,
        faceId: faceId,
        hairId: hairId,
        topId: topId,
        bottomId: bottomId,
        shoesId: shoesId,
      );
    }
    return images;
  }
}

/// 사용 가능한 얼굴 목록
class FaceData {
  static List<Map<String, dynamic>> get availableFaces {
    return FaceSprites.designs.entries.map((e) => {
      'id': e.key,
      'name': e.value['name'],
      'price': e.value['price'],
    }).toList();
  }
}

/// 사용 가능한 헤어스타일 목록
class HairData {
  static List<Map<String, dynamic>> get availableHairs {
    return HairSprites.designs.entries.map((e) => {
      'id': e.key,
      'name': e.value['name'],
      'price': e.value['price'],
    }).toList();
  }
}

/// 사용 가능한 상의 목록
class TopData {
  static List<Map<String, dynamic>> get availableTops {
    return TopSprites.designs.entries.map((e) => {
      'id': e.key,
      'name': e.value['name'],
      'price': e.value['price'],
    }).toList();
  }
}

/// 사용 가능한 하의 목록
class BottomData {
  static List<Map<String, dynamic>> get availableBottoms {
    return BottomSprites.designs.entries.map((e) => {
      'id': e.key,
      'name': e.value['name'],
      'price': e.value['price'],
    }).toList();
  }
}

/// 사용 가능한 신발 목록
class ShoesData {
  static List<Map<String, dynamic>> get availableShoes {
    return ShoesSprites.designs.entries.map((e) => {
      'id': e.key,
      'name': e.value['name'],
      'price': e.value['price'],
    }).toList();
  }
}
