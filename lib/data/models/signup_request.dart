import 'package:json_annotation/json_annotation.dart';

part 'signup_request.g.dart';

/// 회원가입 요청 모델
@JsonSerializable()
class SignupRequest {
  @JsonKey(name: 'member_id')
  final String memberId; // 로그인 아이디

  final String password; // 비밀번호
  final String nickname; // 닉네임

  SignupRequest({
    required this.memberId,
    required this.password,
    required this.nickname,
  });

  factory SignupRequest.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);
}
