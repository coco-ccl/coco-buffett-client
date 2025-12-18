part of 'stock_bloc.dart';

@freezed
sealed class StockEvent with _$StockEvent {
  // initial load events (optional)
  const factory StockEvent.started() = _Started;
}
