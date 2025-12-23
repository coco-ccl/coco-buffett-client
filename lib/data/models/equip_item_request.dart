import 'package:json_annotation/json_annotation.dart';

part 'equip_item_request.g.dart';

/// 아이템 착용 요청 모델
@JsonSerializable()
class EquipItemRequest {
  @JsonKey(name: 'item_id')
  final String itemId; // 착용할 아이템 ID

  EquipItemRequest({
    required this.itemId,
  });

  factory EquipItemRequest.fromJson(Map<String, dynamic> json) =>
      _$EquipItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EquipItemRequestToJson(this);
}
