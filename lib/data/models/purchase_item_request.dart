import 'package:json_annotation/json_annotation.dart';

part 'purchase_item_request.g.dart';

/// 아이템 구매 요청 모델
@JsonSerializable()
class PurchaseItemRequest {
  @JsonKey(name: 'item_id')
  final String itemId; // 구매할 아이템 ID

  PurchaseItemRequest({
    required this.itemId,
  });

  factory PurchaseItemRequest.fromJson(Map<String, dynamic> json) =>
      _$PurchaseItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaseItemRequestToJson(this);
}
