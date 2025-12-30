import 'dart:async';
import '../../asset/asset_bloc/asset_bloc.dart';
import '../api/api_client.dart';
import '../models/member_stock_response.dart';

/// Asset Repository - 자산 데이터 관리 (Stream 기반 캐싱 포함)
class AssetRepository {
  final ApiClient _apiClient;
  final bool _useMockData; // 서버 연결 전 mock 데이터 사용 여부

  // Private 캐시 변수
  int _currentCash = 10000000;
  List<Stock> _myStocks = [];
  String? _lastMemberId; // 마지막으로 조회한 memberId (refresh용)

  // StreamController
  final _cashController = StreamController<int>.broadcast();
  final _stocksController = StreamController<List<Stock>>.broadcast();

  // Public Streams
  Stream<int> get cashStream => _cashController.stream;
  Stream<List<Stock>> get stocksStream => _stocksController.stream;

  // Current values (Synchronous access)
  int get currentCash => _currentCash;
  List<Stock> get myStocks => List.unmodifiable(_myStocks);

  AssetRepository({
    ApiClient? apiClient,
    bool useMockData = true, // 기본값: mock 데이터 사용
  })  : _apiClient = apiClient ?? ApiClient(),
        _useMockData = useMockData;

  /// 회원 주식 정보 조회 (캐시 업데이트 포함)
  Future<AssetData> getMemberStocks(String memberId) async {
    AssetData data;

    if (_useMockData) {
      // Mock 데이터 반환 (서버 연결 전)
      data = _getMockData();
    } else {
      try {
        final response = await _apiClient.getMemberStocks(memberId);

        if (response.code == 0 && response.data != null) {
          data = _convertToAssetData(response.data!);
        } else {
          throw Exception('Failed to load member stocks: ${response.message}');
        }
      } catch (e) {
        throw Exception('Failed to load member stocks: $e');
      }
    }

    // 캐시 업데이트 및 Stream emit
    _currentCash = data.deposit;
    _myStocks = List.from(data.stocks);
    _cashController.add(_currentCash);
    _stocksController.add(List.from(_myStocks));

    return data;
  }

  /// Mock 데이터 반환 (서버 연결 전 테스트용)
  AssetData _getMockData() {
    return AssetData(
      deposit: 10000000,
      stocks: [
        const Stock(
          name: 'Apple Inc.',
          ticker: 'AAPL',
          quantity: 5,
          avgPrice: 150000,
        ),
        const Stock(
          name: 'Tesla Inc.',
          ticker: 'TSLA',
          quantity: 2,
          avgPrice: 200000,
        ),
        const Stock(
          name: 'Microsoft Corporation',
          ticker: 'MSFT',
          quantity: 3,
          avgPrice: 300000,
        ),
      ],
      totalSpent: 0,
      purchaseHistory: [],
    );
  }

  /// DTO를 도메인 모델로 변환
  AssetData _convertToAssetData(MemberStockResponse response) {
    return AssetData(
      deposit: response.deposit,
      stocks: response.stocks
          .map((dto) => Stock(
                name: dto.name,
                ticker: dto.ticker,
                quantity: dto.quantity,
                avgPrice: dto.avgPrice ?? dto.currentPrice, // avgPrice가 없으면 currentPrice 사용
              ))
          .toList(),
      totalSpent: 0, // TODO: 서버에서 제공하는 경우 추가
      purchaseHistory: [], // TODO: 서버에서 제공하는 경우 추가
    );
  }

  /// 초기화 (서버에서 데이터 로드 후 캐시 설정)
  Future<void> initialize({required String memberId}) async {
    _lastMemberId = memberId;
    // getMemberStocks가 캐시 업데이트 및 Stream emit을 수행함
    await getMemberStocks(memberId);
  }

  /// 자산 정보 재조회 (주식 거래 후 호출)
  Future<void> refresh() async {
    if (_lastMemberId == null) {
      throw Exception('AssetRepository not initialized');
    }
    await getMemberStocks(_lastMemberId!);
  }

  /// 주식 매수
  Future<bool> buyStock({
    required String ticker,
    required int quantity,
    required int price,
  }) async {
    final totalCost = price * quantity;

    // 잔고 확인
    if (totalCost > _currentCash) {
      return false;
    }

    // 현금 차감
    _currentCash -= totalCost;

    // 주식 추가/업데이트
    final existingIndex = _myStocks.indexWhere((s) => s.ticker == ticker);
    if (existingIndex != -1) {
      final existing = _myStocks[existingIndex];
      final newQuantity = existing.quantity + quantity;
      final newAvgPrice = ((existing.avgPrice * existing.quantity) + (price * quantity)) ~/ newQuantity;

      _myStocks[existingIndex] = Stock(
        name: existing.name,
        ticker: existing.ticker,
        quantity: newQuantity,
        avgPrice: newAvgPrice,
      );
    } else {
      // 새 주식 추가 (이름은 나중에 업데이트 가능)
      _myStocks.add(Stock(
        name: ticker, // 임시로 ticker를 name으로 사용
        ticker: ticker,
        quantity: quantity,
        avgPrice: price,
      ));
    }

    // Stream 업데이트
    _cashController.add(_currentCash);
    _stocksController.add(List.from(_myStocks));

    return true;
  }

  /// 주식 매도
  Future<bool> sellStock({
    required String ticker,
    required int quantity,
    required int price,
  }) async {
    final existingIndex = _myStocks.indexWhere((s) => s.ticker == ticker);

    // 보유 여부 및 수량 확인
    if (existingIndex == -1 || _myStocks[existingIndex].quantity < quantity) {
      return false;
    }

    final totalRevenue = price * quantity;

    // 현금 증가
    _currentCash += totalRevenue;

    // 주식 수량 감소
    final existing = _myStocks[existingIndex];
    if (existing.quantity == quantity) {
      // 전량 매도 - 제거
      _myStocks.removeAt(existingIndex);
    } else {
      // 일부 매도 - 수량 감소 (평균가는 유지)
      _myStocks[existingIndex] = Stock(
        name: existing.name,
        ticker: existing.ticker,
        quantity: existing.quantity - quantity,
        avgPrice: existing.avgPrice,
      );
    }

    // Stream 업데이트
    _cashController.add(_currentCash);
    _stocksController.add(List.from(_myStocks));

    return true;
  }

  /// 현금 차감 (아이템 구매용)
  Future<bool> deductCash(int amount) async {
    if (amount > _currentCash) {
      return false;
    }

    _currentCash -= amount;
    _cashController.add(_currentCash);

    return true;
  }

  /// 현금 추가 (로컬)
  Future<void> addCash(int amount) async {
    _currentCash += amount;
    _cashController.add(_currentCash);
  }

  /// 현금 추가 (서버 API 호출)
  Future<int> addCashFromServer(int amount) async {
    try {
      final response = await _apiClient.addMoney(amount);

      if (response.code == 0 && response.data != null) {
        // 서버에서 반환한 최신 잔액으로 업데이트
        _currentCash = response.data!.deposit;
        _cashController.add(_currentCash);
        print('[AssetRepository] 돈 추가 성공: $amount원, 현재 잔액: $_currentCash원');
        return _currentCash;
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      print('[AssetRepository] 돈 추가 실패: $e');
      // 서버 호출 실패 시 로컬에만 추가
      _currentCash += amount;
      _cashController.add(_currentCash);
      return _currentCash;
    }
  }

  /// 리소스 정리
  void dispose() {
    _cashController.close();
    _stocksController.close();
  }
}
