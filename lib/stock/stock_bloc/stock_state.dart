part of 'stock_bloc.dart';

enum StockStatus { initial, success, failure, loading }

@freezed
sealed class StockState with _$StockState {
  const factory StockState.data(StockData stockData) = StockDataState;
}

@freezed
sealed class StockData with _$StockData {
  const factory StockData({
    @Default(StockStatus.initial) StockStatus status,
    @Default(10000000) double currentBalance,
    @Default([]) List<Stock> stocks,
    @Default([]) List<PortfolioItem> portfolio,
    @Default({}) Map<String, List<PriceHistory>> priceHistory,
    models.StockEventModel? activeEvent,
    String? selectedStock,
    String? errorMessage,
  }) = _StockData;
}
