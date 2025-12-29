import 'package:json_annotation/json_annotation.dart';

part 'member_stock_response.g.dart';

/// 회원 주식 정보 응답 모델
@JsonSerializable()
class MemberStockResponse {
  final int deposit; // 회원 예치금 (원)
  final List<StockDto> stocks; // 보유 주식 리스트

  MemberStockResponse({
    required this.deposit,
    required this.stocks,
  });

  factory MemberStockResponse.fromJson(Map<String, dynamic> json) =>
      _$MemberStockResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MemberStockResponseToJson(this);
}

/// 주식 DTO
@JsonSerializable()
class StockDto {
  final String name; // 주식 이름
  final String ticker; // 주식 티커
  final int quantity; // 보유 수량 (주)
  @JsonKey(name: 'current_price')
  final int currentPrice; // 현재 주가 (원)
  @JsonKey(name: 'avg_price')
  final int? avgPrice; // 평균 매수가 (원) - 추후 추가 예정

  StockDto({
    required this.name,
    required this.ticker,
    required this.quantity,
    required this.currentPrice,
    this.avgPrice,
  });

  factory StockDto.fromJson(Map<String, dynamic> json) =>
      _$StockDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StockDtoToJson(this);
}
