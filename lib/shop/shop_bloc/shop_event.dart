part of 'shop_bloc.dart';

@freezed
class ShopEvent with _$ShopEvent {
  const factory ShopEvent.started() = _Started;
  const factory ShopEvent.purchaseItem(int itemId) = _PurchaseItem;
  const factory ShopEvent.clearError() = _ClearError;
  const factory ShopEvent.cashUpdated(int cash) = _CashUpdated;
  const factory ShopEvent.ownedItemsUpdated(List<GameItem> items) = _OwnedItemsUpdated;
}
