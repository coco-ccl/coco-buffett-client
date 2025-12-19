import 'package:json_annotation/json_annotation.dart';

part 'purchase_item_response.g.dart';

/// 아이템 구매 응답 모델
@JsonSerializable()
class PurchaseItemResponse {
  @JsonKey(name: 'remaining_deposit')
  final int remainingDeposit; // 구매 후 남은 예치금 (원)

  PurchaseItemResponse({
    required this.remainingDeposit,
  });

  factory PurchaseItemResponse.fromJson(Map<String, dynamic> json) =>
      _$PurchaseItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaseItemResponseToJson(this);
}
