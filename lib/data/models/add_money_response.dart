import 'package:json_annotation/json_annotation.dart';

part 'add_money_response.g.dart';

/// 돈 추가 응답 모델
@JsonSerializable()
class AddMoneyResponse {
  final int deposit;

  AddMoneyResponse({
    required this.deposit,
  });

  factory AddMoneyResponse.fromJson(Map<String, dynamic> json) =>
      _$AddMoneyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddMoneyResponseToJson(this);
}
