import 'dart:async';
import 'dart:math';
import '../api/api_client.dart';
import '../models/tradable_stock_response.dart';
import '../models/trade_stock_request.dart';

/// Stock Repository - 거래 가능 주식 데이터 관리 (Stream 기반 캐싱 및 폴링)
class StockRepository {
  final ApiClient _apiClient;
  final bool _useMockData;
  final Duration pollingInterval;

  // Private 캐시 변수
  List<TradableStock> _tradableStocks = [];

  // Mock 데이터용 기준 가격 (초기값)
  final Map<String, int> _basePrices = {
    'AAPL': 175000,
    'TSLA': 240000,
    'MSFT': 370000,
    'NVDA': 450000,
    'AMZN': 155000,
    'GOOGL': 140000,
  };

  // Mock 데이터용 현재 가격 (등락율 시뮬레이션)
  final Map<String, int> _mockPrices = {
    'AAPL': 175000,
    'TSLA': 240000,
    'MSFT': 370000,
    'NVDA': 450000,
    'AMZN': 155000,
    'GOOGL': 140000,
  };

  // Random 생성기
  final _random = Random();

  // StreamController
  final _tradableStocksController = StreamController<List<TradableStock>>.broadcast();

  // Public Streams
  Stream<List<TradableStock>> get tradableStocksStream => _tradableStocksController.stream;

  // Current values (Synchronous access)
  List<TradableStock> get tradableStocks => List.unmodifiable(_tradableStocks);

  // 폴링 타이머
  Timer? _pollingTimer;

  StockRepository({
    ApiClient? apiClient,
    bool useMockData = true,
    this.pollingInterval = const Duration(seconds: 5), // 기본 5초마다 폴링
  })  : _apiClient = apiClient ?? ApiClient(),
        _useMockData = useMockData;

  /// 거래 가능 주식 리스트 조회 (캐시 업데이트 포함)
  Future<List<TradableStock>> getTradableStocks() async {
    List<TradableStock> stocks;

    if (_useMockData) {
      stocks = _getMockTradableStocks();
    } else {
      final response = await _apiClient.getTradableStocks();
      if (response.code == 0 && response.data != null) {
        stocks = response.data!
            .map((dto) => _convertToTradableStock(dto))
            .toList();
      } else {
        throw Exception('Failed to load tradable stocks');
      }
    }

    // 캐시 업데이트 및 Stream emit
    _tradableStocks = stocks;
    _tradableStocksController.add(List.from(_tradableStocks));

    return stocks;
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

  /// Mock 데이터 반환 (가격 변동 시뮬레이션)
  List<TradableStock> _getMockTradableStocks() {
    // 각 주식의 가격을 -2% ~ +2% 범위에서 랜덤하게 변동
    _mockPrices.forEach((ticker, currentPrice) {
      // -0.02 ~ +0.02 사이의 랜덤 변동률
      final changeRate = (_random.nextDouble() - 0.5) * 0.04; // -2% ~ +2%
      final priceChange = (currentPrice * changeRate).toInt();
      final newPrice = currentPrice + priceChange;

      final basePrice = _basePrices[ticker]!;
      // 기준 가격의 50% ~ 200% 범위로 제한
      _mockPrices[ticker] = newPrice.clamp((basePrice * 0.5).toInt(), (basePrice * 2).toInt());
    });

    return [
      TradableStock(
        name: 'Apple Inc.',
        ticker: 'AAPL',
        currentPrice: _mockPrices['AAPL']!,
      ),
      TradableStock(
        name: 'Tesla Inc.',
        ticker: 'TSLA',
        currentPrice: _mockPrices['TSLA']!,
      ),
      TradableStock(
        name: 'Microsoft Corporation',
        ticker: 'MSFT',
        currentPrice: _mockPrices['MSFT']!,
      ),
      TradableStock(
        name: 'NVIDIA Corporation',
        ticker: 'NVDA',
        currentPrice: _mockPrices['NVDA']!,
      ),
      TradableStock(
        name: 'Amazon.com Inc.',
        ticker: 'AMZN',
        currentPrice: _mockPrices['AMZN']!,
      ),
      TradableStock(
        name: 'Alphabet Inc.',
        ticker: 'GOOGL',
        currentPrice: _mockPrices['GOOGL']!,
      ),
    ];
  }

  /// 초기화 (데이터 로드 및 폴링 시작)
  Future<void> initialize() async {
    // getTradableStocks가 캐시 업데이트 및 Stream emit을 수행함
    await getTradableStocks();

    // 폴링 시작
    startPolling();
  }

  /// 폴링 시작
  void startPolling() {
    // 이미 실행 중이면 중복 실행 방지
    if (_pollingTimer != null && _pollingTimer!.isActive) {
      return;
    }

    _pollingTimer = Timer.periodic(pollingInterval, (_) async {
      try {
        await getTradableStocks();
      } catch (e) {
        // 폴링 중 에러 발생해도 계속 실행
        print('Stock polling error: $e');
      }
    });
  }

  /// 폴링 중지
  void stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  /// 리소스 정리
  void dispose() {
    stopPolling();
    _tradableStocksController.close();
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
