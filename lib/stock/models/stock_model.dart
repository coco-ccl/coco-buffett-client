import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_model.freezed.dart';

/// 주식 종목 모델
@freezed
sealed class Stock with _$Stock {
  const factory Stock({
    required String symbol,
    required String name,
    required double price,
    required double change,
    required int volume,
    @Default(false) bool isLeverage,
    String? baseSymbol,
    String? leverageType, // 'long' or 'short'
  }) = _Stock;
}

/// 가격 히스토리 데이터
@freezed
sealed class PriceHistory with _$PriceHistory {
  const factory PriceHistory({
    required DateTime time,
    required double price,
    required double change,
  }) = _PriceHistory;
}
