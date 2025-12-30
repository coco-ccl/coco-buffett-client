// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tradable_stock_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TradableStockResponse _$TradableStockResponseFromJson(
  Map<String, dynamic> json,
) => TradableStockResponse(
  name: json['name'] as String,
  ticker: json['ticker'] as String,
  currentPrice: (json['current_price'] as num).toInt(),
);

Map<String, dynamic> _$TradableStockResponseToJson(
  TradableStockResponse instance,
) => <String, dynamic>{
  'name': instance.name,
  'ticker': instance.ticker,
  'current_price': instance.currentPrice,
};
