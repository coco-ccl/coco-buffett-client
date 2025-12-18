import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'stock_bloc/stock_bloc.dart';
import 'widgets/candlestick_chart.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  late final StockBloc _stockBloc;
  final TextEditingController _quantityController = TextEditingController();
  bool _isBuyMode = true;
  bool _showChart = false;

  @override
  void initState() {
    super.initState();
    _stockBloc = StockBloc();
    _stockBloc.add(const StockEvent.started());
  }

  @override
  void dispose() {
    _stockBloc.close();
    _quantityController.dispose();
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _stockBloc,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: const Text(
            'Stock Master',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
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

                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            '총 자산',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            '₩${_formatPrice(totalAssets)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
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
            // 이벤트 배너
            if (data.activeEvent != null) _buildEventBanner(data.activeEvent!),

            const SizedBox(height: 16),

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

  Widget _buildEventBanner(dynamic event) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: event.isPositive
              ? [Colors.green.shade400, Colors.blue.shade500, Colors.purple.shade500]
              : [Colors.red.shade500, Colors.pink.shade500, Colors.orange.shade500],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            event.title.split(' ')[0],
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title.substring(event.title.indexOf(' ') + 1),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  event.description,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '이벤트 진행중',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.75),
                  fontSize: 12,
                ),
              ),
              const Text(
                '⏰ 진행중',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioSummary(
    StockData data,
    double portfolioValue,
    double totalProfit,
    double totalProfitRate,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
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
    );
  }

  Widget _buildStockItem(stock, StockData data) {
    final isSelected = data.selectedStock == stock.symbol;
    final isAffectedByEvent = data.activeEvent != null &&
        !stock.isLeverage &&
        ((data.activeEvent!.effect.type.toString().contains('Up') &&
                data.activeEvent!.effect.sectors.contains(stock.symbol)) ||
            data.activeEvent!.effect.type.toString().contains('all'));

    return GestureDetector(
      onTap: () {
        _stockBloc.add(StockEvent.selectStock(stock.symbol));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.grey.shade50,
          border: Border.all(
            color: isSelected ? Colors.blue.shade200 : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: isAffectedByEvent
              ? [
                  BoxShadow(
                    color: Colors.green.withValues(alpha: 0.3),
                    blurRadius: 8,
                  ),
                ]
              : null,
        ),
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
                            horizontal: 4,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: stock.leverageType == 'long'
                                ? Colors.blue
                                : Colors.red,
                            borderRadius: BorderRadius.circular(4),
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
                      if (isAffectedByEvent) ...[
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'HOT!',
                            style: TextStyle(
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
    );
  }

  Widget _buildTradingPanel(StockData data) {
    final selectedStock = data.stocks.firstWhere(
      (s) => s.symbol == data.selectedStock,
    );
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    final totalAmount = selectedStock.price * quantity;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
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

          const SizedBox(height: 16),

          // 차트 영역
          if (_showChart) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
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
            const SizedBox(height: 16),
          ],

          // 매수/매도 버튼
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isBuyMode = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _isBuyMode ? Colors.red : Colors.grey.shade300,
                    foregroundColor: _isBuyMode ? Colors.white : Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('매수'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isBuyMode = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        !_isBuyMode ? Colors.blue : Colors.grey.shade300,
                    foregroundColor: !_isBuyMode ? Colors.white : Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('매도'),
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
          TextField(
            controller: _quantityController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '주문할 수량을 입력하세요',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
            ),
            onChanged: (_) => setState(() {}),
          ),

          const SizedBox(height: 16),

          // 예상 금액
          if (quantity > 0)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.yellow.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
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

          const SizedBox(height: 16),

          // 주문 버튼
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: quantity > 0
                  ? () {
                      if (_isBuyMode) {
                        _stockBloc.add(StockEvent.buyStock(
                          symbol: selectedStock.symbol,
                          quantity: quantity,
                        ));
                      } else {
                        _stockBloc.add(StockEvent.sellStock(
                          symbol: selectedStock.symbol,
                          quantity: quantity,
                        ));
                      }
                      _quantityController.clear();
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isBuyMode ? Colors.red : Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                disabledBackgroundColor: Colors.grey.shade300,
              ),
              child: Text(
                '${_isBuyMode ? '매수' : '매도'} 주문',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
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
    );
  }

  Widget _buildPortfolio(StockData data) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
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
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
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
              );
            }),
        ],
      ),
    );
  }
}
