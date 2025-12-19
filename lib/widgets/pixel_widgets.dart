import 'package:flutter/material.dart';

/// 픽셀 스타일 모서리를 만드는 커스텀 클리퍼
class PixelClipper extends CustomClipper<Path> {
  final double notchSize;

  PixelClipper({this.notchSize = 4.0});

  @override
  Path getClip(Size size) {
    final path = Path();

    // 왼쪽 상단
    path.moveTo(notchSize, 0);
    path.lineTo(size.width - notchSize, 0);

    // 오른쪽 상단 노치
    path.lineTo(size.width - notchSize, notchSize);
    path.lineTo(size.width, notchSize);
    path.lineTo(size.width, size.height - notchSize);

    // 오른쪽 하단 노치
    path.lineTo(size.width - notchSize, size.height - notchSize);
    path.lineTo(size.width - notchSize, size.height);
    path.lineTo(notchSize, size.height);

    // 왼쪽 하단 노치
    path.lineTo(notchSize, size.height - notchSize);
    path.lineTo(0, size.height - notchSize);
    path.lineTo(0, notchSize);

    // 왼쪽 상단 노치
    path.lineTo(notchSize, notchSize);
    path.lineTo(notchSize, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(PixelClipper oldClipper) => notchSize != oldClipper.notchSize;
}

/// 픽셀 스타일 테두리를 그리는 페인터
class PixelBorderPainter extends CustomPainter {
  final Color borderColor;
  final double borderWidth;
  final double notchSize;
  final bool has3DEffect;

  PixelBorderPainter({
    required this.borderColor,
    this.borderWidth = 3.0,
    this.notchSize = 4.0,
    this.has3DEffect = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final path = Path();

    // 왼쪽 상단
    path.moveTo(notchSize, borderWidth / 2);
    path.lineTo(size.width - notchSize, borderWidth / 2);

    // 오른쪽 상단 노치
    path.lineTo(size.width - notchSize, notchSize);
    path.lineTo(size.width - borderWidth / 2, notchSize);
    path.lineTo(size.width - borderWidth / 2, size.height - notchSize);

    // 오른쪽 하단 노치
    path.lineTo(size.width - notchSize, size.height - notchSize);
    path.lineTo(size.width - notchSize, size.height - borderWidth / 2);
    path.lineTo(notchSize, size.height - borderWidth / 2);

    // 왼쪽 하단 노치
    path.lineTo(notchSize, size.height - notchSize);
    path.lineTo(borderWidth / 2, size.height - notchSize);
    path.lineTo(borderWidth / 2, notchSize);

    // 왼쪽 상단 노치
    path.lineTo(notchSize, notchSize);
    path.lineTo(notchSize, borderWidth / 2);

    canvas.drawPath(path, paint);

    // 3D 베벨 효과 추가
    if (has3DEffect) {
      final bevelWidth = borderWidth + 2;

      // 밝은 베벨 (왼쪽 + 상단)
      final highlightPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.7)
        ..style = PaintingStyle.fill;

      // 상단 베벨
      final topBevel = Path();
      topBevel.moveTo(notchSize, borderWidth);
      topBevel.lineTo(size.width - notchSize, borderWidth);
      topBevel.lineTo(size.width - notchSize - bevelWidth, borderWidth + bevelWidth);
      topBevel.lineTo(notchSize + bevelWidth, borderWidth + bevelWidth);
      topBevel.close();
      canvas.drawPath(topBevel, highlightPaint);

      // 왼쪽 베벨
      final leftBevel = Path();
      leftBevel.moveTo(borderWidth, notchSize);
      leftBevel.lineTo(borderWidth + bevelWidth, notchSize + bevelWidth);
      leftBevel.lineTo(borderWidth + bevelWidth, size.height - notchSize - bevelWidth);
      leftBevel.lineTo(borderWidth, size.height - notchSize);
      leftBevel.close();
      canvas.drawPath(leftBevel, highlightPaint);

      // 어두운 베벨 (오른쪽 + 하단)
      final shadowPaint = Paint()
        ..color = Colors.black.withValues(alpha: 0.4)
        ..style = PaintingStyle.fill;

      // 하단 베벨
      final bottomBevel = Path();
      bottomBevel.moveTo(notchSize + bevelWidth, size.height - borderWidth - bevelWidth);
      bottomBevel.lineTo(size.width - notchSize - bevelWidth, size.height - borderWidth - bevelWidth);
      bottomBevel.lineTo(size.width - notchSize, size.height - borderWidth);
      bottomBevel.lineTo(notchSize, size.height - borderWidth);
      bottomBevel.close();
      canvas.drawPath(bottomBevel, shadowPaint);

      // 오른쪽 베벨
      final rightBevel = Path();
      rightBevel.moveTo(size.width - borderWidth - bevelWidth, notchSize + bevelWidth);
      rightBevel.lineTo(size.width - borderWidth, notchSize);
      rightBevel.lineTo(size.width - borderWidth, size.height - notchSize);
      rightBevel.lineTo(size.width - borderWidth - bevelWidth, size.height - notchSize - bevelWidth);
      rightBevel.close();
      canvas.drawPath(rightBevel, shadowPaint);
    }
  }

  @override
  bool shouldRepaint(PixelBorderPainter oldDelegate) =>
      borderColor != oldDelegate.borderColor ||
      borderWidth != oldDelegate.borderWidth ||
      notchSize != oldDelegate.notchSize ||
      has3DEffect != oldDelegate.has3DEffect;
}
