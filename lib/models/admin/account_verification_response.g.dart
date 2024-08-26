// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_verification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountVerificationResponse _$AccountVerificationResponseFromJson(
        Map<String, dynamic> json) =>
    AccountVerificationResponse(
      success: json['success'] as bool? ?? false,
      msg: json['msg'] as String? ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              AccountVerificationData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AccountVerificationResponseToJson(
        AccountVerificationResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'msg': instance.msg,
      'data': instance.data,
    };

AccountVerificationData _$AccountVerificationDataFromJson(
        Map<String, dynamic> json) =>
    AccountVerificationData(
      id: (json['id'] as num?)?.toInt(),
      nik: json['nik'] as String?,
      name: json['name'] as String?,
      img_url: json['img_url'] as String?,
    );

Map<String, dynamic> _$AccountVerificationDataToJson(
        AccountVerificationData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nik': instance.nik,
      'name': instance.name,
      'img_url': instance.img_url,
    };
