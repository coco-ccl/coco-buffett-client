// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberInfoResponse _$MemberInfoResponseFromJson(Map<String, dynamic> json) =>
    MemberInfoResponse(
      id: json['id'] as String,
      nickname: json['nickname'] as String,
      profileImageUrl: json['profile_image_url'] as String?,
    );

Map<String, dynamic> _$MemberInfoResponseToJson(MemberInfoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'profile_image_url': instance.profileImageUrl,
    };
