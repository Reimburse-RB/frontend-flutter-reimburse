// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    ProfileResponse(
      success: json['success'] as bool? ?? false,
      msg: json['msg'] as String? ?? '',
      data: json['data'] == null
          ? null
          : ProfileData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'msg': instance.msg,
      'data': instance.data,
    };

EditProfileResponse _$EditProfileResponseFromJson(Map<String, dynamic> json) =>
    EditProfileResponse(
      success: json['success'] as bool? ?? false,
      msg: json['msg'] as String? ?? '',
      data: json['data'] == null
          ? null
          : AuthUserData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EditProfileResponseToJson(
        EditProfileResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'msg': instance.msg,
      'data': instance.data,
    };

ProfileData _$ProfileDataFromJson(Map<String, dynamic> json) => ProfileData(
      nik: json['nik'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      role_id: (json['role_id'] as num?)?.toInt(),
      role_text: json['role_text'] as String? ?? '',
      img_url: json['img_url'] as String?,
      family_member_data: (json['family_member_data'] as List<dynamic>?)
              ?.map((e) => FamilyMemberData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ProfileDataToJson(ProfileData instance) =>
    <String, dynamic>{
      'nik': instance.nik,
      'name': instance.name,
      'email': instance.email,
      'role_id': instance.role_id,
      'role_text': instance.role_text,
      'img_url': instance.img_url,
      'family_member_data': instance.family_member_data,
    };

FamilyMemberData _$FamilyMemberDataFromJson(Map<String, dynamic> json) =>
    FamilyMemberData(
      id: (json['id'] as num?)?.toInt(),
      family_status_id: (json['family_status_id'] as num?)?.toInt(),
      family_status_text: json['family_status_text'] as String? ?? '',
      name: json['name'] as String? ?? '',
    );

Map<String, dynamic> _$FamilyMemberDataToJson(FamilyMemberData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'family_status_id': instance.family_status_id,
      'family_status_text': instance.family_status_text,
      'name': instance.name,
    };

FamilyMemberOption _$FamilyMemberOptionFromJson(Map<String, dynamic> json) =>
    FamilyMemberOption(
      family_status_id: (json['family_status_id'] as num?)?.toInt(),
      family_status_text: json['family_status_text'] as String,
    );

Map<String, dynamic> _$FamilyMemberOptionToJson(FamilyMemberOption instance) =>
    <String, dynamic>{
      'family_status_id': instance.family_status_id,
      'family_status_text': instance.family_status_text,
    };
