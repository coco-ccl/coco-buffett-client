// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipped_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EquippedItemResponse _$EquippedItemResponseFromJson(
  Map<String, dynamic> json,
) => EquippedItemResponse(
  itemId: (json['itemId'] as num).toInt(),
  type: json['type'] as String,
  color: json['color'] as String,
);

Map<String, dynamic> _$EquippedItemResponseToJson(
  EquippedItemResponse instance,
) => <String, dynamic>{
  'itemId': instance.itemId,
  'type': instance.type,
  'color': instance.color,
};
