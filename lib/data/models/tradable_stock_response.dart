import 'package:json_annotation/json_annotation.dart';

part 'tradable_stock_response.g.dart';

/// 거래 가능 주식 응답 모델
@JsonSerializable()
class TradableStockResponse {
  final String name; // 주식 이름
  final String ticker; // 주식 티커
  @JsonKey(name: 'current_price')
  final int currentPrice; // 현재 주가 (원)

  TradableStockResponse({
    required this.name,
    required this.ticker,
    required this.currentPrice,
  });

  factory TradableStockResponse.fromJson(Map<String, dynamic> json) =>
      _$TradableStockResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TradableStockResponseToJson(this);
}
