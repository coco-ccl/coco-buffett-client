import 'package:json_annotation/json_annotation.dart';

part 'trade_stock_request.g.dart';

/// 주식 거래 요청 모델
@JsonSerializable()
class TradeStockRequest {
  final String ticker; // 거래할 주식 티커
  @JsonKey(name: 'trade_type')
  final String tradeType; // 거래 유형 (BUY: 매수, SELL: 매도)
  final int quantity; // 거래 수량 (주)
  final int price; // 거래 단가 (원)

  TradeStockRequest({
    required this.ticker,
    required this.tradeType,
    required this.quantity,
    required this.price,
  });

  factory TradeStockRequest.fromJson(Map<String, dynamic> json) =>
      _$TradeStockRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TradeStockRequestToJson(this);

  /// 매수 요청 생성
  factory TradeStockRequest.buy({
    required String ticker,
    required int quantity,
    required int price,
  }) {
    return TradeStockRequest(
      ticker: ticker,
      tradeType: 'BUY',
      quantity: quantity,
      price: price,
    );
  }

  /// 매도 요청 생성
  factory TradeStockRequest.sell({
    required String ticker,
    required int quantity,
    required int price,
  }) {
    return TradeStockRequest(
      ticker: ticker,
      tradeType: 'SELL',
      quantity: quantity,
      price: price,
    );
  }
}

/// 거래 유형 상수
class TradeType {
  static const String buy = 'BUY';
  static const String sell = 'SELL';
}
