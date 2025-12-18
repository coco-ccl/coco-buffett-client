import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/stock_model.dart';

class CandlestickChart extends StatelessWidget {
  final List<PriceHistory> history;
  final double width;
  final double height;

  const CandlestickChart({
    super.key,
    required this.history,
    this.width = 400,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    if (history.length < 2) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 8),
              Text(
                '📊 차트 데이터 수집 중...',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 4),
              Text(
                '몇 초 후 차트가 표시됩니다',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CustomPaint(
        size: Size(width, height),
        painter: CandlestickChartPainter(history),
      ),
    );
  }
}

class CandlestickChartPainter extends CustomPainter {
  final List<PriceHistory> history;

  CandlestickChartPainter(this.history);

  @override
  void paint(Canvas canvas, Size size) {
    if (history.length < 2) return;

    final maxPrice = history.map((h) => h.price).reduce(math.max);
    final minPrice = history.map((h) => h.price).reduce(math.min);
    final priceRange = maxPrice - minPrice;
    if (priceRange == 0) return;

    const padding = 20.0;
    final chartWidth = size.width - 2 * padding;
    final chartHeight = size.height - 2 * padding;
    final candleWidth = math.max(2.0, chartWidth / history.length - 1);

    // 격자 배경 그리기
    _drawGrid(canvas, size, padding);

    // 캔들스틱 그리기
    for (int i = 1; i < history.length; i++) {
      final prevPrice = history[i - 1].price;
      final currentPrice = history[i].price;
      final isUp = currentPrice >= prevPrice;

      final x = padding + (i / (history.length - 1)) * chartWidth;
      final currentY = size.height -
          padding -
          ((currentPrice - minPrice) / priceRange) * chartHeight;
      final prevY = size.height -
          padding -
          ((prevPrice - minPrice) / priceRange) * chartHeight;

      final candleColor = isUp ? Colors.red : Colors.blue;
      final candleHeight = (currentY - prevY).abs();
      final candleTop = math.min(currentY, prevY);

      // 캔들 몸통
      final candleRect = Rect.fromLTWH(
        x - candleWidth / 2,
        candleTop,
        candleWidth,
        math.max(candleHeight, 1),
      );

      final candlePaint = Paint()
        ..color = candleColor
        ..style = PaintingStyle.fill;

      canvas.drawRect(candleRect, candlePaint);

      // 캔들 테두리
      final borderPaint = Paint()
        ..color = candleColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;

      canvas.drawRect(candleRect, borderPaint);

      // 심지 (간략화)
      final wickPaint = Paint()
        ..color = candleColor
        ..strokeWidth = 1;

      canvas.drawLine(Offset(x, prevY), Offset(x, currentY), wickPaint);

      // 포인트
      final pointPaint = Paint()..color = candleColor;
      canvas.drawCircle(Offset(x, currentY), 2, pointPaint);
    }

    // 가격 레이블
    _drawPriceLabels(canvas, size, padding, maxPrice, minPrice);

    // 현재가 라인
    _drawCurrentPriceLine(canvas, size, padding, chartWidth, chartHeight,
        minPrice, priceRange);

    // 볼륨 차트 (하단)
    _drawVolumeChart(canvas, size, padding, chartWidth, history);
  }

  void _drawGrid(Canvas canvas, Size size, double padding) {
    final gridPaint = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = 1;

    // 수평선
    for (int i = 0; i <= 4; i++) {
      final y = padding + (size.height - 2 * padding) * i / 4;
      canvas.drawLine(
        Offset(padding, y),
        Offset(size.width - padding, y),
        gridPaint,
      );
    }

    // 수직선
    for (int i = 0; i <= 5; i++) {
      final x = padding + (size.width - 2 * padding) * i / 5;
      canvas.drawLine(
        Offset(x, padding),
        Offset(x, size.height - padding),
        gridPaint,
      );
    }
  }

  void _drawPriceLabels(Canvas canvas, Size size, double padding,
      double maxPrice, double minPrice) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    // 최고가 레이블
    textPainter.text = TextSpan(
      text: '₩${_formatPrice(maxPrice)}',
      style: const TextStyle(
        fontSize: 10,
        color: Colors.grey,
      ),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(padding, padding - 10));

    // 최저가 레이블
    textPainter.text = TextSpan(
      text: '₩${_formatPrice(minPrice)}',
      style: const TextStyle(
        fontSize: 10,
        color: Colors.grey,
      ),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(padding, size.height - padding));
  }

  void _drawCurrentPriceLine(Canvas canvas, Size size, double padding,
      double chartWidth, double chartHeight, double minPrice, double priceRange) {
    if (history.isEmpty) return;

    final lastPrice = history.last.price;
    final lastChange = history.last.change;
    final lineColor = lastChange >= 0 ? Colors.red : Colors.blue;

    final lastY = size.height -
        padding -
        ((lastPrice - minPrice) / priceRange) * chartHeight;

    // 점선
    final linePaint = Paint()
      ..color = lineColor.withValues(alpha: 0.7)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final dashWidth = 3.0;
    final dashSpace = 3.0;
    double startX = padding;

    while (startX < size.width - padding) {
      canvas.drawLine(
        Offset(startX, lastY),
        Offset(math.min(startX + dashWidth, size.width - padding), lastY),
        linePaint,
      );
      startX += dashWidth + dashSpace;
    }

    // 현재가 텍스트
    final textPainter = TextPainter(
      text: TextSpan(
        text: '₩${_formatPrice(lastPrice)}',
        style: TextStyle(
          fontSize: 10,
          color: lineColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(size.width - padding - 65, lastY - 15),
    );
  }

  void _drawVolumeChart(Canvas canvas, Size size, double padding,
      double chartWidth, List<PriceHistory> history) {
    const volumeHeight = 20.0;

    for (int i = 1; i < history.length; i++) {
      final prevPrice = history[i - 1].price;
      final isUp = history[i].price >= prevPrice;
      final volumeColor =
          (isUp ? Colors.red : Colors.blue).withValues(alpha: 0.6);

      final x = padding + (i / (history.length - 1)) * chartWidth;
      final candleWidth = math.max(2.0, chartWidth / history.length - 1);

      final volumeRect = Rect.fromLTWH(
        x - candleWidth / 2,
        size.height - padding - volumeHeight,
        candleWidth,
        volumeHeight,
      );

      final volumePaint = Paint()..color = volumeColor;
      canvas.drawRect(volumeRect, volumePaint);
    }
  }

  String _formatPrice(double price) {
    if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(0)}K';
    }
    return price.toStringAsFixed(0);
  }

  @override
  bool shouldRepaint(CandlestickChartPainter oldDelegate) {
    return history != oldDelegate.history;
  }
}
