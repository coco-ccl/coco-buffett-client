// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemResponse _$ItemResponseFromJson(Map<String, dynamic> json) => ItemResponse(
  itemId: json['item_id'] as String,
  type: json['type'] as String,
  name: json['name'] as String?,
  price: (json['price'] as num).toInt(),
  color: json['color'] as String,
  isOwned: json['is_owned'] as bool?,
);

Map<String, dynamic> _$ItemResponseToJson(ItemResponse instance) =>
    <String, dynamic>{
      'item_id': instance.itemId,
      'type': instance.type,
      'name': instance.name,
      'price': instance.price,
      'color': instance.color,
      'is_owned': instance.isOwned,
    };
