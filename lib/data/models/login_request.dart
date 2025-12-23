import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

/// 로그인 요청 모델
@JsonSerializable()
class LoginRequest {
  @JsonKey(name: 'member_id')
  final String memberId;
  final String password;

  LoginRequest({
    required this.memberId,
    required this.password,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
