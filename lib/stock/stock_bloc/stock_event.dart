part of 'stock_bloc.dart';

@freezed
sealed class StockEvent with _$StockEvent {
  const factory StockEvent.started() = _Started;
  const factory StockEvent.buyStock({
    required String symbol,
    required int quantity,
  }) = _BuyStock;
  const factory StockEvent.sellStock({
    required String symbol,
    required int quantity,
  }) = _SellStock;
  const factory StockEvent.updatePrices() = _UpdatePrices;
  const factory StockEvent.triggerEvent(models.StockEventModel event) = _TriggerEvent;
  const factory StockEvent.clearEvent() = _ClearEvent;
  const factory StockEvent.selectStock(String symbol) = _SelectStock;
}
