import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// SVG 이미지를 사용하기 위한 유틸리티 클래스
class SvgUtils {
  /// assets/icons/ 폴더의 SVG 파일을 로드
  ///
  /// 사용 예시:
  /// ```dart
  /// SvgUtils.loadIcon('icon_name.svg', width: 24, height: 24)
  /// ```
  static Widget loadIcon(
    String fileName, {
    double? width,
    double? height,
    Color? color,
    BoxFit fit = BoxFit.contain,
  }) {
    return SvgPicture.asset(
      'assets/icons/$fileName',
      width: width,
      height: height,
      colorFilter: color != null
          ? ColorFilter.mode(color, BlendMode.srcIn)
          : null,
      fit: fit,
    );
  }

  /// assets/images/ 폴더의 SVG 파일을 로드
  ///
  /// 사용 예시:
  /// ```dart
  /// SvgUtils.loadImage('image_name.svg', width: 100, height: 100)
  /// ```
  static Widget loadImage(
    String fileName, {
    double? width,
    double? height,
    Color? color,
    BoxFit fit = BoxFit.contain,
  }) {
    return SvgPicture.asset(
      'assets/images/$fileName',
      width: width,
      height: height,
      colorFilter: color != null
          ? ColorFilter.mode(color, BlendMode.srcIn)
          : null,
      fit: fit,
    );
  }

  /// 네트워크에서 SVG 파일을 로드
  ///
  /// 사용 예시:
  /// ```dart
  /// SvgUtils.loadFromNetwork('https://example.com/icon.svg', width: 24, height: 24)
  /// ```
  static Widget loadFromNetwork(
    String url, {
    double? width,
    double? height,
    Color? color,
    BoxFit fit = BoxFit.contain,
  }) {
    return SvgPicture.network(
      url,
      width: width,
      height: height,
      colorFilter: color != null
          ? ColorFilter.mode(color, BlendMode.srcIn)
          : null,
      fit: fit,
    );
  }

  /// SVG 문자열을 직접 로드
  ///
  /// 사용 예시:
  /// ```dart
  /// SvgUtils.loadFromString(
  ///   '<svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/></svg>',
  ///   width: 24,
  ///   height: 24,
  /// )
  /// ```
  static Widget loadFromString(
    String svgString, {
    double? width,
    double? height,
    Color? color,
    BoxFit fit = BoxFit.contain,
  }) {
    return SvgPicture.string(
      svgString,
      width: width,
      height: height,
      colorFilter: color != null
          ? ColorFilter.mode(color, BlendMode.srcIn)
          : null,
      fit: fit,
    );
  }
}
