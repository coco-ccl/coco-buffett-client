import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'stock_bloc/stock_bloc.dart';
import 'widgets/candlestick_chart.dart';
import '../widgets/pixel_widgets.dart';
import '../data/repositories/asset_repository.dart';
import '../data/repositories/stock_repository.dart';
import '../services/bgm_service.dart';

/// StockPage Wrapper - BLoC 제공
class StockPage extends StatelessWidget {
  const StockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StockBloc(
        assetRepository: context.read<AssetRepository>(),
        stockRepository: context.read<StockRepository>(),
      )..add(const StockEvent.started()),
      child: const _StockPageContent(),
    );
  }
}

/// StockPage 실제 내용
class _StockPageContent extends StatefulWidget {
  const _StockPageContent();

  @override
  State<_StockPageContent> createState() => _StockPageState();
}

class _StockPageState extends State<_StockPageContent> {
  final TextEditingController _quantityController = TextEditingController();
  final BgmService _bgmService = BgmService();
  bool _isBuyMode = true;
  bool _showChart = false;

  @override
  void initState() {
    super.initState();
    // 주식 페이지 BGM 재생
    _bgmService.play(BgmType.stock);
  }

  @override
  void dispose() {
    _quantityController.dispose();
    // 홈 BGM으로 복귀
    _bgmService.play(BgmType.home);
    super.dispose();
  }

  String _formatPrice(double price) {
    return price.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  String _formatChange(double change) {
    return '${change >= 0 ? '+' : ''}${change.toStringAsFixed(2)}%';
  }

  Widget _pixelBox({
    required Widget child,
    Color borderColor = const Color(0xFF4A90E2),
    Color? backgroundColor,
  }) {
    return ClipPath(
      clipper: PixelClipper(notchSize: 6),
      child: CustomPaint(
        painter: PixelBorderPainter(
          borderColor: borderColor,
          borderWidth: 3,
          notchSize: 6,
          has3DEffect: true,
        ),
        child: Container(
          color: backgroundColor ?? Colors.white,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DC), // 베이지 배경
      appBar: AppBar(
        title: const Text(
          '주식 거래소',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF4A90E2), // 모던 블루
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        actions: [
          BlocBuilder<StockBloc, StockState>(
            builder: (context, state) {
              return state.maybeWhen(
                data: (data) {
                  final portfolioValue = data.portfolio.fold<double>(
                    0,
                    (sum, item) {
                      final stock = data.stocks.firstWhere(
                        (s) => s.symbol == item.symbol,
                      );
                      return sum + (stock.price * item.quantity);
                    },
                  );
                  final totalAssets = data.currentBalance + portfolioValue;
                  final numberFormat = NumberFormat('#,###');

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.account_balance_wallet, color: Color(0xFFFFD700), size: 20),
                        const SizedBox(width: 6),
                        Text(
                          '₩${numberFormat.format(totalAssets.toInt())}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                orElse: () => const SizedBox(),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<StockBloc, StockState>(
        builder: (context, state) {
          return state.maybeWhen(
            data: (data) => _buildMainContent(context, data),
            orElse: () => const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, StockData data) {
    final portfolioValue = data.portfolio.fold<double>(
      0,
      (sum, item) {
        final stock = data.stocks.firstWhere((s) => s.symbol == item.symbol);
        return sum + (stock.price * item.quantity);
      },
    );

    final portfolioCost = data.portfolio.fold<double>(
      0,
      (sum, item) => sum + (item.avgPrice * item.quantity),
    );

    final totalProfit = portfolioValue - portfolioCost;
    final totalProfitRate =
        portfolioCost > 0 ? (totalProfit / portfolioCost) * 100 : 0;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 포트폴리오 요약
            _buildPortfolioSummary(
                data, portfolioValue.toDouble(), totalProfit.toDouble(), totalProfitRate.toDouble()),

            const SizedBox(height: 16),

            // 메인 콘텐츠 (3단 구성)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. 종목 목록 (왼쪽)
                Expanded(
                  flex: 5,
                  child: _buildStockList(data),
                ),

                const SizedBox(width: 16),

                // 2. 거래 패널 (중앙)
                Expanded(
                  flex: 4,
                  child: _buildTradingPanel(data),
                ),

                const SizedBox(width: 16),

                // 3. 보유 종목 (오른쪽)
                Expanded(
                  flex: 3,
                  child: _buildPortfolio(data),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPortfolioSummary(
    StockData data,
    double portfolioValue,
    double totalProfit,
    double totalProfitRate,
  ) {
    return ClipPath(
      clipper: PixelClipper(notchSize: 6),
      child: CustomPaint(
        painter: PixelBorderPainter(
          borderColor: const Color(0xFF4A90E2),
          borderWidth: 3,
          notchSize: 6,
          has3DEffect: true,
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  '보유현금',
                  '₩${_formatPrice(data.currentBalance)}',
                  Colors.blue,
                ),
              ),
              Expanded(
                child: _buildSummaryItem(
                  '주식평가금액',
                  '₩${_formatPrice(portfolioValue)}',
                  Colors.purple,
                ),
              ),
              Expanded(
                child: _buildSummaryItem(
                  '총 수익률',
                  '${totalProfitRate >= 0 ? '+' : ''}${totalProfitRate.toStringAsFixed(2)}%',
                  totalProfitRate >= 0 ? Colors.green : Colors.red,
                ),
              ),
              Expanded(
                child: _buildSummaryItem(
                  '총 손익금',
                  '${totalProfit >= 0 ? '+' : ''}₩${_formatPrice(totalProfit.abs())}',
                  totalProfit >= 0 ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildStockList(StockData data) {
    return _pixelBox(
      backgroundColor: const Color(0xFFEEE8D5), // 베이지와 어울리는 따뜻한 톤
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.trending_up, size: 20),
              SizedBox(width: 8),
              Text(
                '종목 현황',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...data.stocks.map((stock) => _buildStockItem(stock, data)),
        ],
        ),
      ),
    );
  }

  Widget _buildStockItem(stock, StockData data) {
    final isSelected = data.selectedStock == stock.symbol;

    return GestureDetector(
      onTap: () {
        context.read<StockBloc>().add(StockEvent.selectStock(stock.symbol));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: ClipPath(
          clipper: PixelClipper(notchSize: 4),
          child: CustomPaint(
            painter: PixelBorderPainter(
              borderColor: isSelected ? const Color(0xFF4A90E2) : Colors.black.withValues(alpha: 0.2),
              borderWidth: isSelected ? 3 : 2,
              notchSize: 4,
              has3DEffect: isSelected,
            ),
            child: Container(
              padding: const EdgeInsets.all(12),
              color: isSelected ? const Color(0xFFE3F2FD) : Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              stock.symbol,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            if (stock.isLeverage) ...[
                              const SizedBox(width: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: stock.leverageType == 'long'
                                      ? Colors.blue
                                      : Colors.red,
                                ),
                                child: Text(
                                  stock.leverageType == 'long' ? '2X↗' : '2X↙',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        Text(
                          stock.name,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '₩${_formatPrice(stock.price)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _formatChange(stock.change),
                        style: TextStyle(
                          fontSize: 12,
                          color: stock.change >= 0 ? Colors.red : Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTradingPanel(StockData data) {
    final selectedStock = data.stocks.firstWhere(
      (s) => s.symbol == data.selectedStock,
    );
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    final totalAmount = selectedStock.price * quantity;

    return _pixelBox(
      backgroundColor: const Color(0xFFEEE8D5),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.monetization_on, size: 20),
                  SizedBox(width: 8),
                  Text(
                    '주문',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    _showChart = !_showChart;
                  });
                },
                icon: const Icon(Icons.bar_chart, size: 16),
                label: const Text('차트'),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 선택된 주식 정보
          ClipPath(
            clipper: PixelClipper(notchSize: 4),
            child: Container(
              padding: const EdgeInsets.all(12),
              color: Colors.white,
              child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedStock.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '₩${_formatPrice(selectedStock.price)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _formatChange(selectedStock.change),
                      style: TextStyle(
                        fontSize: 12,
                        color: selectedStock.change >= 0
                            ? Colors.red
                            : Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // 차트 영역
          if (_showChart) ...[
            ClipPath(
              clipper: PixelClipper(notchSize: 4),
              child: Container(
                padding: const EdgeInsets.all(12),
                color: Colors.white,
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '실시간 캔들 차트',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 12,
                                height: 8,
                                child: ColoredBox(color: Colors.red),
                              ),
                              SizedBox(width: 4),
                              Text('상승', style: TextStyle(fontSize: 10)),
                            ],
                          ),
                          SizedBox(width: 12),
                          Row(
                            children: [
                              SizedBox(
                                width: 12,
                                height: 8,
                                child: ColoredBox(color: Colors.blue),
                              ),
                              SizedBox(width: 4),
                              Text('하락', style: TextStyle(fontSize: 10)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: CandlestickChart(
                      history: data.priceHistory[selectedStock.symbol] ?? [],
                      width: 350,
                      height: 180,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '📈 캔들: ${data.priceHistory[selectedStock.symbol]?.length ?? 0}개',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                      const Text(
                        '🔄 3초마다 업데이트',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // 매수/매도 버튼
          Row(
            children: [
              Expanded(
                child: ClipPath(
                  clipper: PixelClipper(notchSize: 4),
                  child: Material(
                    color: _isBuyMode ? Colors.red : const Color(0xFFE0E0E0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _isBuyMode = true;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        child: Text(
                          '매수',
                          style: TextStyle(
                            color: _isBuyMode ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ClipPath(
                  clipper: PixelClipper(notchSize: 4),
                  child: Material(
                    color: !_isBuyMode ? Colors.blue : const Color(0xFFE0E0E0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _isBuyMode = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        child: Text(
                          '매도',
                          style: TextStyle(
                            color: !_isBuyMode ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 수량 입력
          const Text(
            '수량',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ClipPath(
            clipper: PixelClipper(notchSize: 4),
            child: Container(
              color: Colors.white,
              child: TextField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: '주문할 수량을 입력하세요',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(12),
                ),
                onChanged: (_) => setState(() {}),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // 예상 금액
          if (quantity > 0)
            ClipPath(
              clipper: PixelClipper(notchSize: 4),
              child: CustomPaint(
                painter: PixelBorderPainter(
                  borderColor: const Color(0xFFFDD835),
                  borderWidth: 2,
                  notchSize: 4,
                ),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  color: const Color(0xFFFFFDE7),
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '예상 ${_isBuyMode ? '매수' : '매도'}대금',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    '₩${_formatPrice(totalAmount)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                  ),
                ),
              ),
            ),

          const SizedBox(height: 16),

          // 주문 버튼
          ClipPath(
            clipper: PixelClipper(notchSize: 4),
            child: CustomPaint(
              painter: PixelBorderPainter(
                borderColor: quantity > 0
                    ? (_isBuyMode ? Colors.red.shade800 : Colors.blue.shade800)
                    : Colors.grey,
                borderWidth: 3,
                notchSize: 4,
                has3DEffect: quantity > 0,
              ),
              child: Material(
                color: quantity > 0
                    ? (_isBuyMode ? Colors.red : Colors.blue)
                    : const Color(0xFFE0E0E0),
                child: InkWell(
                  onTap: quantity > 0
                      ? () {
                          if (_isBuyMode) {
                            context.read<StockBloc>().add(StockEvent.buyStock(
                              symbol: selectedStock.symbol,
                              quantity: quantity,
                            ));
                          } else {
                            context.read<StockBloc>().add(StockEvent.sellStock(
                              symbol: selectedStock.symbol,
                              quantity: quantity,
                            ));
                          }
                          _quantityController.clear();
                        }
                      : null,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    alignment: Alignment.center,
                    child: Text(
                      '${_isBuyMode ? '매수' : '매도'} 주문',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: quantity > 0 ? Colors.white : Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 에러 메시지
          if (data.errorMessage != null) ...[
            const SizedBox(height: 8),
            Text(
              data.errorMessage!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ],
        ],
        ),
      ),
    );
  }

  Widget _buildPortfolio(StockData data) {
    return _pixelBox(
      borderColor: const Color(0xFF9C27B0),
      backgroundColor: const Color(0xFFEEE8D5),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.pie_chart, size: 20),
              SizedBox(width: 8),
              Text(
                '보유 종목',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (data.portfolio.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  '보유 중인 종목이 없습니다',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            )
          else
            ...data.portfolio.map((item) {
              final stock = data.stocks.firstWhere(
                (s) => s.symbol == item.symbol,
              );
              final currentValue = stock.price * item.quantity;
              final profit = currentValue - (item.avgPrice * item.quantity);
              final profitRate =
                  (profit / (item.avgPrice * item.quantity)) * 100;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: ClipPath(
                  clipper: PixelClipper(notchSize: 3),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    color: Colors.white,
                    child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.symbol,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${item.quantity}주',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '₩${_formatPrice(currentValue)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${profit >= 0 ? '+' : ''}₩${_formatPrice(profit.abs())} (${profitRate >= 0 ? '+' : ''}${profitRate.toStringAsFixed(2)}%)',
                              style: TextStyle(
                                fontSize: 10,
                                color: profit >= 0 ? Colors.red : Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
