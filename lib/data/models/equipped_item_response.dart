import 'package:json_annotation/json_annotation.dart';

part 'equipped_item_response.g.dart';

/// 착용 아이템 응답 모델
@JsonSerializable()
class EquippedItemResponse {
  @JsonKey(name: 'item_id')
  final String itemId; // 아이템 ID (스프라이트 ID)
  final String type; // 종류 (top, bottom, face, hair, shoes)
  final String color; // 아이템 색상

  EquippedItemResponse({
    required this.itemId,
    required this.type,
    required this.color,
  });

  factory EquippedItemResponse.fromJson(Map<String, dynamic> json) =>
      _$EquippedItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EquippedItemResponseToJson(this);
}
