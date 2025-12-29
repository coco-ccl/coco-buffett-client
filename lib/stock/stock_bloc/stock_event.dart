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
  const factory StockEvent.selectStock(String symbol) = _SelectStock;
  const factory StockEvent.stocksUpdated(List<Stock> stocks) = _StocksUpdated;
  const factory StockEvent.cashUpdated(int cash) = _CashUpdated;
  const factory StockEvent.portfolioUpdated(List<asset.Stock> assetStocks) = _PortfolioUpdated;
}
