import 'package:json_annotation/json_annotation.dart';

part 'member_info_response.g.dart';

/// 회원 정보 응답 모델
@JsonSerializable()
class MemberInfoResponse {
  final int memberNo; // 회원 고유 no
  final String id; // 로그인 아이디
  final String nickname; // 닉네임
  final String? profileImageUrl; // 프로필 이미지 URL (nullable)

  MemberInfoResponse({
    required this.memberNo,
    required this.id,
    required this.nickname,
    this.profileImageUrl,
  });

  factory MemberInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$MemberInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MemberInfoResponseToJson(this);
}
