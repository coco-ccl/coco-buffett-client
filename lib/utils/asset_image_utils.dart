import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// SVG와 일반 이미지 파일(PNG, JPG 등)을 통합으로 사용할 수 있는 유틸리티 클래스
/// 파일 확장자에 따라 자동으로 적절한 위젯을 반환합니다.
class AssetImageUtils {
  /// assets/icons/ 폴더의 이미지 파일을 로드 (SVG, PNG, JPG 자동 감지)
  ///
  /// 사용 예시:
  /// ```dart
  /// AssetImageUtils.loadIcon('icon.svg', width: 24, height: 24)
  /// AssetImageUtils.loadIcon('icon.png', width: 24, height: 24, color: Colors.red)
  /// ```
  static Widget loadIcon(
    String fileName, {
    double? width,
    double? height,
    Color? color,
    BoxFit fit = BoxFit.contain,
  }) {
    return _loadAsset(
      'assets/icons/$fileName',
      width: width,
      height: height,
      color: color,
      fit: fit,
    );
  }

  /// assets/images/ 폴더의 이미지 파일을 로드 (SVG, PNG, JPG 자동 감지)
  ///
  /// 사용 예시:
  /// ```dart
  /// AssetImageUtils.loadImage('logo.svg', width: 100, height: 100)
  /// AssetImageUtils.loadImage('background.jpg', width: 200, height: 150)
  /// ```
  static Widget loadImage(
    String fileName, {
    double? width,
    double? height,
    Color? color,
    BoxFit fit = BoxFit.contain,
  }) {
    return _loadAsset(
      'assets/images/$fileName',
      width: width,
      height: height,
      color: color,
      fit: fit,
    );
  }

  /// 네트워크에서 이미지를 로드 (SVG, PNG, JPG 자동 감지)
  ///
  /// 사용 예시:
  /// ```dart
  /// AssetImageUtils.loadFromNetwork('https://example.com/icon.svg', width: 24)
  /// AssetImageUtils.loadFromNetwork('https://example.com/photo.jpg', width: 200)
  /// ```
  static Widget loadFromNetwork(
    String url, {
    double? width,
    double? height,
    Color? color,
    BoxFit fit = BoxFit.contain,
  }) {
    if (_isSvg(url)) {
      return SvgPicture.network(
        url,
        width: width,
        height: height,
        colorFilter: color != null
            ? ColorFilter.mode(color, BlendMode.srcIn)
            : null,
        fit: fit,
        placeholderBuilder: (context) => _buildLoadingPlaceholder(width, height),
      );
    } else {
      return Image.network(
        url,
        width: width,
        height: height,
        fit: fit,
        color: color,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildLoadingPlaceholder(width, height);
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorPlaceholder(width, height);
        },
      );
    }
  }

  /// 내부 메서드: Asset 파일 로드 (SVG와 일반 이미지 자동 구분)
  static Widget _loadAsset(
    String assetPath, {
    double? width,
    double? height,
    Color? color,
    BoxFit fit = BoxFit.contain,
  }) {
    if (_isSvg(assetPath)) {
      // SVG 파일
      return SvgPicture.asset(
        assetPath,
        width: width,
        height: height,
        colorFilter: color != null
            ? ColorFilter.mode(color, BlendMode.srcIn)
            : null,
        fit: fit,
      );
    } else {
      // PNG, JPG 등 일반 이미지 파일
      return Image.asset(
        assetPath,
        width: width,
        height: height,
        fit: fit,
        color: color,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorPlaceholder(width, height);
        },
      );
    }
  }

  /// 파일이 SVG인지 확인
  static bool _isSvg(String path) {
    return path.toLowerCase().endsWith('.svg');
  }

  /// 로딩 중 표시할 플레이스홀더
  static Widget _buildLoadingPlaceholder(double? width, double? height) {
    return SizedBox(
      width: width ?? 50,
      height: height ?? 50,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  /// 에러 발생 시 표시할 플레이스홀더
  static Widget _buildErrorPlaceholder(double? width, double? height) {
    return Icon(
      Icons.broken_image,
      size: width ?? height ?? 50,
      color: Colors.grey,
    );
  }
}
