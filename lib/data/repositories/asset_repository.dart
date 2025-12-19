import '../../asset/asset_bloc/asset_bloc.dart';
import '../api/api_client.dart';
import '../models/member_stock_response.dart';

/// Asset Repository - 자산 데이터 관리
class AssetRepository {
  final ApiClient _apiClient;
  final bool _useMockData; // 서버 연결 전 mock 데이터 사용 여부

  AssetRepository({
    ApiClient? apiClient,
    bool useMockData = true, // 기본값: mock 데이터 사용
  })  : _apiClient = apiClient ?? ApiClient(),
        _useMockData = useMockData;

  /// 회원 주식 정보 조회
  Future<AssetData> getMemberStocks(int memberId) async {
    if (_useMockData) {
      // Mock 데이터 반환 (서버 연결 전)
      return _getMockData();
    }

    try {
      final response = await _apiClient.getMemberStocks(memberId);

      if (response.code == 0 && response.data != null) {
        return _convertToAssetData(response.data!);
      } else {
        throw Exception('Failed to load member stocks: ${response.message}');
      }
    } catch (e) {
      throw Exception('Failed to load member stocks: $e');
    }
  }

  /// Mock 데이터 반환 (서버 연결 전 테스트용)
  AssetData _getMockData() {
    return AssetData(
      deposit: 10000,
      stocks: [
        const Stock(
          name: 'Apple Inc.',
          ticker: 'AAPL',
          quantity: 5,
        ),
        const Stock(
          name: 'Tesla Inc.',
          ticker: 'TSLA',
          quantity: 2,
        ),
        const Stock(
          name: 'Microsoft Corporation',
          ticker: 'MSFT',
          quantity: 3,
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
              ))
          .toList(),
      totalSpent: 0, // TODO: 서버에서 제공하는 경우 추가
      purchaseHistory: [], // TODO: 서버에서 제공하는 경우 추가
    );
  }
}
