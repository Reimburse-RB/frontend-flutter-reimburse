// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpResponse _$SignUpResponseFromJson(Map<String, dynamic> json) =>
    SignUpResponse(
      success: json['success'] as bool? ?? false,
      msg: json['msg'] as String? ?? '',
      data: json['data'] == null
          ? null
          : AuthUserData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignUpResponseToJson(SignUpResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'msg': instance.msg,
      'data': instance.data,
    };

SignInResponse _$SignInResponseFromJson(Map<String, dynamic> json) =>
    SignInResponse(
      success: json['success'] as bool? ?? false,
      msg: json['msg'] as String? ?? '',
      token: json['token'] as String? ?? '',
      user: json['user'] == null
          ? null
          : AuthUserData.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignInResponseToJson(SignInResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'msg': instance.msg,
      'token': instance.token,
      'user': instance.user,
    };

AuthUserData _$AuthUserDataFromJson(Map<String, dynamic> json) => AuthUserData(
      id: (json['id'] as num?)?.toInt(),
      fullname: json['fullname'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      identity_number: json['identity_number'] as String?,
      role: (json['role'] as num?)?.toInt(),
      token: json['token'] as String?,
      status: (json['status'] as num?)?.toInt(),
      image_url: json['image_url'] as String?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
    );

Map<String, dynamic> _$AuthUserDataToJson(AuthUserData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullname': instance.fullname,
      'email': instance.email,
      'password': instance.password,
      'identity_number': instance.identity_number,
      'role': instance.role,
      'token': instance.token,
      'status': instance.status,
      'image_url': instance.image_url,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
