import 'package:json_annotation/json_annotation.dart';

part 'add_money_request.g.dart';

/// 돈 추가 요청 모델
@JsonSerializable()
class AddMoneyRequest {
  final int amount;

  AddMoneyRequest({
    required this.amount,
  });

  factory AddMoneyRequest.fromJson(Map<String, dynamic> json) =>
      _$AddMoneyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddMoneyRequestToJson(this);
}
