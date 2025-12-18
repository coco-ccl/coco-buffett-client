import 'package:flutter/material.dart';

/// PNG, JPG 등 일반 이미지 파일을 사용하기 위한 유틸리티 클래스
class ImageUtils {
  /// assets/icons/ 폴더의 이미지 파일을 로드
  ///
  /// 사용 예시:
  /// ```dart
  /// ImageUtils.loadIcon('icon.png', width: 24, height: 24)
  /// ```
  static Widget loadIcon(
    String fileName, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Color? color,
  }) {
    return Image.asset(
      'assets/icons/$fileName',
      width: width,
      height: height,
      fit: fit,
      color: color,
    );
  }

  /// assets/images/ 폴더의 이미지 파일을 로드
  ///
  /// 사용 예시:
  /// ```dart
  /// ImageUtils.loadImage('logo.png', width: 100, height: 100)
  /// ```
  static Widget loadImage(
    String fileName, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
  }) {
    return Image.asset(
      'assets/images/$fileName',
      width: width,
      height: height,
      fit: fit,
    );
  }

  /// 네트워크에서 이미지를 로드
  ///
  /// 사용 예시:
  /// ```dart
  /// ImageUtils.loadFromNetwork('https://example.com/image.png', width: 100)
  /// ```
  static Widget loadFromNetwork(
    String url, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
  }) {
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return SizedBox(
          width: width ?? 50,
          height: height ?? 50,
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Icon(
          Icons.error,
          size: width ?? 50,
          color: Colors.red,
        );
      },
    );
  }

  /// 메모리에서 이미지를 로드 (Uint8List)
  ///
  /// 사용 예시:
  /// ```dart
  /// ImageUtils.loadFromMemory(bytes, width: 100, height: 100)
  /// ```
  static Widget loadFromMemory(
    dynamic bytes, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
  }) {
    return Image.memory(
      bytes,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
