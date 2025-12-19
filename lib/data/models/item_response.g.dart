// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemResponse _$ItemResponseFromJson(Map<String, dynamic> json) => ItemResponse(
  itemId: (json['item_id'] as num).toInt(),
  type: json['type'] as String,
  color: json['color'] as String,
  price: (json['price'] as num).toInt(),
  isOwned: json['is_owned'] as bool,
);

Map<String, dynamic> _$ItemResponseToJson(ItemResponse instance) =>
    <String, dynamic>{
      'item_id': instance.itemId,
      'type': instance.type,
      'color': instance.color,
      'price': instance.price,
      'is_owned': instance.isOwned,
    };
