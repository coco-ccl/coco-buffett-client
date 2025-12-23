// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipped_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EquippedItemResponse _$EquippedItemResponseFromJson(
  Map<String, dynamic> json,
) => EquippedItemResponse(
  itemId: json['item_id'] as String,
  type: json['type'] as String,
  color: json['color'] as String,
);

Map<String, dynamic> _$EquippedItemResponseToJson(
  EquippedItemResponse instance,
) => <String, dynamic>{
  'item_id': instance.itemId,
  'type': instance.type,
  'color': instance.color,
};
