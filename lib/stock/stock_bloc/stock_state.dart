part of 'stock_bloc.dart';

enum StockStatus { initial, success, failure, loading }

@freezed
sealed class StockState with _$StockState {
  const factory StockState.empty(StockData data) = StockEmpty;
}

@freezed
abstract class StockData with _$StockData {
  const factory StockData({
    @Default(StockStatus.initial) StockStatus status,
    @Default([]) List<String> stockList,
  }) = _StockData;
}
