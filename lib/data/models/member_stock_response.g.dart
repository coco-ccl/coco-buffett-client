// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_stock_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberStockResponse _$MemberStockResponseFromJson(Map<String, dynamic> json) =>
    MemberStockResponse(
      deposit: (json['deposit'] as num).toInt(),
      stocks: (json['stocks'] as List<dynamic>)
          .map((e) => StockDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MemberStockResponseToJson(
  MemberStockResponse instance,
) => <String, dynamic>{'deposit': instance.deposit, 'stocks': instance.stocks};

StockDto _$StockDtoFromJson(Map<String, dynamic> json) => StockDto(
  name: json['name'] as String,
  ticker: json['ticker'] as String,
  quantity: (json['quantity'] as num).toInt(),
  currentPrice: (json['current_price'] as num).toInt(),
  averageCost: (json['average_cost'] as num?)?.toInt(),
);

Map<String, dynamic> _$StockDtoToJson(StockDto instance) => <String, dynamic>{
  'name': instance.name,
  'ticker': instance.ticker,
  'quantity': instance.quantity,
  'current_price': instance.currentPrice,
  'average_cost': instance.averageCost,
};
