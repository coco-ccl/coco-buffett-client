part of 'asset_bloc.dart';

@freezed
sealed class AssetEvent with _$AssetEvent {
  /// 시작
  const factory AssetEvent.started() = _Started;

  /// 예치금 변경
  const factory AssetEvent.depositChanged(int amount) = _DepositChanged;

  /// 아이템 구매
  const factory AssetEvent.itemPurchased({
    required String itemName,
    required int price,
  }) = _ItemPurchased;

  /// 잔액 추가
  const factory AssetEvent.balanceAdded(int amount) = _BalanceAdded;

  /// 현금 업데이트 (Repository로부터)
  const factory AssetEvent.cashUpdated(int cash) = _CashUpdated;

  /// 보유 주식 업데이트 (Repository로부터)
  const factory AssetEvent.stocksUpdated(List<Stock> stocks) = _StocksUpdated;
}
