import '../api/api_client.dart';
import '../models/tradable_stock_response.dart';
import '../models/trade_stock_request.dart';

/// Stock Repository - 거래 가능 주식 데이터 관리
class StockRepository {
  final ApiClient _apiClient;
  final bool _useMockData;

  StockRepository({
    ApiClient? apiClient,
    bool useMockData = true,
  })  : _apiClient = apiClient ?? ApiClient(),
        _useMockData = useMockData;

  /// 거래 가능 주식 리스트 조회
  Future<List<TradableStock>> getTradableStocks() async {
    if (_useMockData) {
      return _getMockTradableStocks();
    }

    final response = await _apiClient.getTradableStocks();
    if (response.code == 0 && response.data != null) {
      return response.data!
          .map((dto) => _convertToTradableStock(dto))
          .toList();
    }

    throw Exception('Failed to load tradable stocks');
  }

  /// DTO를 도메인 모델로 변환
  TradableStock _convertToTradableStock(TradableStockResponse response) {
    return TradableStock(
      name: response.name,
      ticker: response.ticker,
      currentPrice: response.currentPrice,
    );
  }

  /// 주식 거래 (매수/매도)
  Future<void> tradeStock({
    required String ticker,
    required String tradeType,
    required int quantity,
    required int price,
  }) async {
    if (_useMockData) {
      // Mock 모드에서는 아무것도 하지 않음 (성공으로 간주)
      await Future.delayed(const Duration(milliseconds: 500));
      return;
    }

    final request = TradeStockRequest(
      ticker: ticker,
      tradeType: tradeType,
      quantity: quantity,
      price: price,
    );

    final response = await _apiClient.tradeStock(request);
    if (response.code != 0) {
      throw Exception(response.message);
    }
  }

  /// 주식 매수
  Future<void> buyStock({
    required String ticker,
    required int quantity,
    required int price,
  }) async {
    return tradeStock(
      ticker: ticker,
      tradeType: 'BUY',
      quantity: quantity,
      price: price,
    );
  }

  /// 주식 매도
  Future<void> sellStock({
    required String ticker,
    required int quantity,
    required int price,
  }) async {
    return tradeStock(
      ticker: ticker,
      tradeType: 'SELL',
      quantity: quantity,
      price: price,
    );
  }

  /// Mock 데이터 반환
  List<TradableStock> _getMockTradableStocks() {
    return const [
      TradableStock(
        name: 'Apple Inc.',
        ticker: 'AAPL',
        currentPrice: 175000,
      ),
      TradableStock(
        name: 'Tesla Inc.',
        ticker: 'TSLA',
        currentPrice: 240000,
      ),
      TradableStock(
        name: 'Microsoft Corporation',
        ticker: 'MSFT',
        currentPrice: 370000,
      ),
      TradableStock(
        name: 'NVIDIA Corporation',
        ticker: 'NVDA',
        currentPrice: 450000,
      ),
      TradableStock(
        name: 'Amazon.com Inc.',
        ticker: 'AMZN',
        currentPrice: 155000,
      ),
      TradableStock(
        name: 'Alphabet Inc.',
        ticker: 'GOOGL',
        currentPrice: 140000,
      ),
    ];
  }
}

/// 거래 가능 주식 도메인 모델
class TradableStock {
  final String name;
  final String ticker;
  final int currentPrice; // 현재 주가 (원)

  const TradableStock({
    required this.name,
    required this.ticker,
    required this.currentPrice,
  });
}
