import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'asset_bloc/asset_bloc.dart';

class AssetPage extends StatelessWidget {
  const AssetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('#,###');

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DC), // 베이지 배경
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.account_balance_wallet, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text('내 자산', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
        backgroundColor: const Color(0xFF4A90E2), // 모던 블루
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        elevation: 0,
      ),
      body: BlocBuilder<AssetBloc, AssetState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 잔액 카드
                _PixelCard(
                  child: Column(
                    children: [
                      _PixelLabel(
                        text: '현재 잔액',
                        color: const Color(0xFF4A90E2),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.account_balance_wallet,
                            color: Color(0xFF4A90E2),
                            size: 32,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${numberFormat.format(state.data.deposit)}원',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // 통계 카드
                _PixelCard(
                  child: Column(
                    children: [
                      _PixelLabel(
                        text: '자산 통계',
                        color: const Color(0xFF4A90E2),
                      ),
                      const SizedBox(height: 16),
                      _StatRow(
                        icon: Icons.shopping_cart,
                        label: '총 지출',
                        value: '${numberFormat.format(state.data.totalSpent)} G',
                        color: Colors.red,
                      ),
                      const SizedBox(height: 12),
                      _StatRow(
                        icon: Icons.receipt_long,
                        label: '구매 횟수',
                        value: '${state.data.purchaseHistory.length}회',
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // 보유 주식 목록
                _PixelCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _PixelLabel(
                        text: '보유 주식',
                        color: const Color(0xFF4A90E2),
                      ),
                      const SizedBox(height: 16),
                      if (state.data.stocks.isEmpty)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(24.0),
                            child: Text(
                              '보유 중인 주식이 없습니다',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        )
                      else
                        ...state.data.stocks.map((stock) {
                          return _StockItem(stock: stock);
                        }).toList(),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // 구매 내역
                _PixelCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _PixelLabel(
                        text: '최근 구매 내역',
                        color: const Color(0xFF4A90E2),
                      ),
                      const SizedBox(height: 16),
                      if (state.data.purchaseHistory.isEmpty)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(24.0),
                            child: Text(
                              '아직 구매 내역이 없습니다',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        )
                      else
                        ...state.data.purchaseHistory.reversed.take(10).map((record) {
                          return _PurchaseHistoryItem(
                            record: record,
                            numberFormat: numberFormat,
                          );
                        }).toList(),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // 잔액 추가 버튼 (테스트용)
                _PixelButton(
                  onPressed: () {
                    context.read<AssetBloc>().add(const AssetEvent.balanceAdded(1000));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Row(
                          children: [
                            Icon(Icons.add_circle, color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Text(
                              '1,000 G가 추가되었습니다!',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        duration: Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Color(0xFF4A90E2),
                      ),
                    );
                  },
                  text: '잔액 추가 (+1,000 G)',
                  icon: Icons.add_circle,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// 픽셀 스타일 카드
class _PixelCard extends StatelessWidget {
  final Widget child;

  const _PixelCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _PixelClipper(notchSize: 6),
      child: CustomPaint(
        painter: _PixelBorderPainter(
          borderColor: Colors.black,
          borderWidth: 3,
          notchSize: 6,
          has3DEffect: true,
        ),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          child: child,
        ),
      ),
    );
  }
}

/// 픽셀 스타일 라벨
class _PixelLabel extends StatelessWidget {
  final String text;
  final Color color;

  const _PixelLabel({
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _PixelClipper(notchSize: 3),
      child: CustomPaint(
        painter: _PixelBorderPainter(
          borderColor: Colors.black,
          borderWidth: 2,
          notchSize: 3,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          color: color,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

/// 통계 행
class _StatRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

/// 보유 주식 아이템
class _StockItem extends StatelessWidget {
  final Stock stock;

  const _StockItem({
    required this.stock,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF4A90E2).withOpacity(0.1),
              border: Border.all(color: const Color(0xFF4A90E2), width: 2),
            ),
            child: const Icon(Icons.show_chart, size: 24, color: Color(0xFF4A90E2)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stock.name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  stock.ticker,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Text(
              '${stock.quantity}주',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 구매 내역 아이템
class _PurchaseHistoryItem extends StatelessWidget {
  final PurchaseRecord record;
  final NumberFormat numberFormat;

  const _PurchaseHistoryItem({
    required this.record,
    required this.numberFormat,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MM/dd HH:mm');

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Row(
        children: [
          const Icon(Icons.shopping_bag, size: 20, color: Color(0xFF4A90E2)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  record.itemName,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  dateFormat.format(record.timestamp),
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '-${numberFormat.format(record.price)} G',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

/// 픽셀 스타일 버튼
class _PixelButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData icon;

  const _PixelButton({
    required this.onPressed,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _PixelClipper(notchSize: 4),
      child: CustomPaint(
        painter: _PixelBorderPainter(
          borderColor: Colors.black,
          borderWidth: 3,
          notchSize: 4,
          has3DEffect: true,
        ),
        child: Material(
          color: const Color(0xFF4A90E2),
          child: InkWell(
            onTap: onPressed,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: Colors.white, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 픽셀 스타일 모서리를 만드는 커스텀 클리퍼
class _PixelClipper extends CustomClipper<Path> {
  final double notchSize;

  _PixelClipper({this.notchSize = 4.0});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(notchSize, 0);
    path.lineTo(size.width - notchSize, 0);
    path.lineTo(size.width - notchSize, notchSize);
    path.lineTo(size.width, notchSize);
    path.lineTo(size.width, size.height - notchSize);
    path.lineTo(size.width - notchSize, size.height - notchSize);
    path.lineTo(size.width - notchSize, size.height);
    path.lineTo(notchSize, size.height);
    path.lineTo(notchSize, size.height - notchSize);
    path.lineTo(0, size.height - notchSize);
    path.lineTo(0, notchSize);
    path.lineTo(notchSize, notchSize);
    path.lineTo(notchSize, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_PixelClipper oldClipper) => notchSize != oldClipper.notchSize;
}

/// 픽셀 스타일 테두리를 그리는 페인터
class _PixelBorderPainter extends CustomPainter {
  final Color borderColor;
  final double borderWidth;
  final double notchSize;
  final bool has3DEffect;

  _PixelBorderPainter({
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
    path.moveTo(notchSize, borderWidth / 2);
    path.lineTo(size.width - notchSize, borderWidth / 2);
    path.lineTo(size.width - notchSize, notchSize);
    path.lineTo(size.width - borderWidth / 2, notchSize);
    path.lineTo(size.width - borderWidth / 2, size.height - notchSize);
    path.lineTo(size.width - notchSize, size.height - notchSize);
    path.lineTo(size.width - notchSize, size.height - borderWidth / 2);
    path.lineTo(notchSize, size.height - borderWidth / 2);
    path.lineTo(notchSize, size.height - notchSize);
    path.lineTo(borderWidth / 2, size.height - notchSize);
    path.lineTo(borderWidth / 2, notchSize);
    path.lineTo(notchSize, notchSize);
    path.lineTo(notchSize, borderWidth / 2);

    canvas.drawPath(path, paint);

    // 3D 베벨 효과
    if (has3DEffect) {
      final bevelWidth = borderWidth + 2;

      final highlightPaint = Paint()
        ..color = Colors.white.withOpacity(0.7)
        ..style = PaintingStyle.fill;

      final topBevel = Path();
      topBevel.moveTo(notchSize, borderWidth);
      topBevel.lineTo(size.width - notchSize, borderWidth);
      topBevel.lineTo(size.width - notchSize - bevelWidth, borderWidth + bevelWidth);
      topBevel.lineTo(notchSize + bevelWidth, borderWidth + bevelWidth);
      topBevel.close();
      canvas.drawPath(topBevel, highlightPaint);

      final leftBevel = Path();
      leftBevel.moveTo(borderWidth, notchSize);
      leftBevel.lineTo(borderWidth + bevelWidth, notchSize + bevelWidth);
      leftBevel.lineTo(borderWidth + bevelWidth, size.height - notchSize - bevelWidth);
      leftBevel.lineTo(borderWidth, size.height - notchSize);
      leftBevel.close();
      canvas.drawPath(leftBevel, highlightPaint);

      final shadowPaint = Paint()
        ..color = Colors.black.withOpacity(0.4)
        ..style = PaintingStyle.fill;

      final bottomBevel = Path();
      bottomBevel.moveTo(notchSize + bevelWidth, size.height - borderWidth - bevelWidth);
      bottomBevel.lineTo(size.width - notchSize - bevelWidth, size.height - borderWidth - bevelWidth);
      bottomBevel.lineTo(size.width - notchSize, size.height - borderWidth);
      bottomBevel.lineTo(notchSize, size.height - borderWidth);
      bottomBevel.close();
      canvas.drawPath(bottomBevel, shadowPaint);

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
  bool shouldRepaint(_PixelBorderPainter oldDelegate) =>
      borderColor != oldDelegate.borderColor ||
      borderWidth != oldDelegate.borderWidth ||
      notchSize != oldDelegate.notchSize ||
      has3DEffect != oldDelegate.has3DEffect;
}
