// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberInfoResponse _$MemberInfoResponseFromJson(Map<String, dynamic> json) =>
    MemberInfoResponse(
      memberNo: (json['memberNo'] as num).toInt(),
      id: json['id'] as String,
      nickname: json['nickname'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
    );

Map<String, dynamic> _$MemberInfoResponseToJson(MemberInfoResponse instance) =>
    <String, dynamic>{
      'memberNo': instance.memberNo,
      'id': instance.id,
      'nickname': instance.nickname,
      'profileImageUrl': instance.profileImageUrl,
    };
