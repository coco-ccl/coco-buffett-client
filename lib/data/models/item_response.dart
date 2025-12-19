import 'package:json_annotation/json_annotation.dart';

part 'item_response.g.dart';

/// 아이템 응답 모델
@JsonSerializable()
class ItemResponse {
  @JsonKey(name: 'item_id')
  final int itemId; // 아이템 ID

  final String type; // 종류 (top, bottom, face, hair, shoes)
  final String color; // 아이템 색상
  final int price; // 가격 (원)

  @JsonKey(name: 'is_owned')
  final bool isOwned; // 보유 여부

  ItemResponse({
    required this.itemId,
    required this.type,
    required this.color,
    required this.price,
    required this.isOwned,
  });

  factory ItemResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ItemResponseToJson(this);
}
