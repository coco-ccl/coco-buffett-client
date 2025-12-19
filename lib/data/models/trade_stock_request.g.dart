// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_stock_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TradeStockRequest _$TradeStockRequestFromJson(Map<String, dynamic> json) =>
    TradeStockRequest(
      ticker: json['ticker'] as String,
      tradeType: json['tradeType'] as String,
      quantity: (json['quantity'] as num).toInt(),
      price: (json['price'] as num).toInt(),
    );

Map<String, dynamic> _$TradeStockRequestToJson(TradeStockRequest instance) =>
    <String, dynamic>{
      'ticker': instance.ticker,
      'tradeType': instance.tradeType,
      'quantity': instance.quantity,
      'price': instance.price,
    };
