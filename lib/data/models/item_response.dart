import 'package:json_annotation/json_annotation.dart';

part 'item_response.g.dart';

/// 아이템 응답 모델
@JsonSerializable()
class ItemResponse {
  @JsonKey(name: 'item_id')
  final String itemId; // 아이템 ID (스프라이트 ID)

  final String type; // 종류 (top, bottom, face, hair, shoes)
  final String? name; // 아이템 이름 (한글) - owned API에서는 null
  final int price; // 가격 (원)
  final String color; // 아이템 색상 (메타데이터)

  @JsonKey(name: 'is_owned')
  final bool? isOwned; // 보유 여부 - owned API에서는 null

  ItemResponse({
    required this.itemId,
    required this.type,
    this.name,
    required this.price,
    required this.color,
    this.isOwned,
  });

  factory ItemResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ItemResponseToJson(this);
}
