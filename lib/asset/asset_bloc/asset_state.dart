part of 'asset_bloc.dart';

@freezed
sealed class AssetState with _$AssetState {
  const factory AssetState(AssetData data) = _AssetState;
}

@freezed
abstract class AssetData with _$AssetData {
  const factory AssetData({
    required int deposit, // 예치금 (원)
    required List<Stock> stocks, // 보유 주식 리스트
    required int totalSpent, // 총 지출
    required List<PurchaseRecord> purchaseHistory, // 구매 내역
  }) = _AssetData;
}

/// 보유 주식
@freezed
abstract class Stock with _$Stock {
  const factory Stock({
    required String name, // 주식 이름
    required String ticker, // 주식 티커
    required int quantity, // 보유 수량 (주)
    @Default(0) int avgPrice, // 평균 매수가 (원)
  }) = _Stock;
}

/// 구매 기록
@freezed
abstract class PurchaseRecord with _$PurchaseRecord {
  const factory PurchaseRecord({
    required String itemName,
    required int price,
    required DateTime timestamp,
  }) = _PurchaseRecord;
}
