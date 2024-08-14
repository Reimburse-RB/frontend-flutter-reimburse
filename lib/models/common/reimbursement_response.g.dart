// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reimbursement_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurposeOptionResponse _$PurposeOptionResponseFromJson(
        Map<String, dynamic> json) =>
    PurposeOptionResponse(
      success: json['success'] as bool? ?? false,
      msg: json['msg'] as String? ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map(
                  (e) => PurposeOptionData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PurposeOptionResponseToJson(
        PurposeOptionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'msg': instance.msg,
      'data': instance.data,
    };

PurposeOptionData _$PurposeOptionDataFromJson(Map<String, dynamic> json) =>
    PurposeOptionData(
      purpose_id: (json['purpose_id'] as num?)?.toInt(),
      purpose_text: json['purpose_text'] as String?,
    );

Map<String, dynamic> _$PurposeOptionDataToJson(PurposeOptionData instance) =>
    <String, dynamic>{
      'purpose_id': instance.purpose_id,
      'purpose_text': instance.purpose_text,
    };

DetailCostOptionResponse _$DetailCostOptionResponseFromJson(
        Map<String, dynamic> json) =>
    DetailCostOptionResponse(
      success: json['success'] as bool? ?? false,
      msg: json['msg'] as String? ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((e) =>
                  DetailCostOptionData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$DetailCostOptionResponseToJson(
        DetailCostOptionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'msg': instance.msg,
      'data': instance.data,
    };

DetailCostOptionData _$DetailCostOptionDataFromJson(
        Map<String, dynamic> json) =>
    DetailCostOptionData(
      detail_title_id: (json['detail_title_id'] as num?)?.toInt(),
      detail_title_text: json['detail_title_text'] as String?,
    );

Map<String, dynamic> _$DetailCostOptionDataToJson(
        DetailCostOptionData instance) =>
    <String, dynamic>{
      'detail_title_id': instance.detail_title_id,
      'detail_title_text': instance.detail_title_text,
    };

AddReimburseResponse _$AddReimburseResponseFromJson(
        Map<String, dynamic> json) =>
    AddReimburseResponse(
      success: json['success'] as bool? ?? false,
      msg: json['msg'] as String? ?? '',
      data: json['data'] == null
          ? null
          : AddReimburseData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddReimburseResponseToJson(
        AddReimburseResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'msg': instance.msg,
      'data': instance.data,
    };

AddReimburseData _$AddReimburseDataFromJson(Map<String, dynamic> json) =>
    AddReimburseData(
      status: (json['status'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      purpose_id: (json['purpose_id'] as num?)?.toInt(),
      purpose_other: json['purpose_other'] as String?,
      user_id: (json['user_id'] as num?)?.toInt(),
      category: (json['category'] as num?)?.toInt(),
      updatedAt: json['updatedAt'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$AddReimburseDataToJson(AddReimburseData instance) =>
    <String, dynamic>{
      'status': instance.status,
      'id': instance.id,
      'purpose_id': instance.purpose_id,
      'purpose_other': instance.purpose_other,
      'user_id': instance.user_id,
      'category': instance.category,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
    };

GetUserReimburseResponse _$GetUserReimburseResponseFromJson(
        Map<String, dynamic> json) =>
    GetUserReimburseResponse(
      success: json['success'] as bool? ?? false,
      msg: json['msg'] as String? ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => GetUserReimburseData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetUserReimburseResponseToJson(
        GetUserReimburseResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'msg': instance.msg,
      'data': instance.data,
    };

GetUserReimburseData _$GetUserReimburseDataFromJson(
        Map<String, dynamic> json) =>
    GetUserReimburseData(
      id: (json['id'] as num?)?.toInt(),
      typeReimburse: json['typeReimburse'] as String?,
      status: json['status'] as String?,
      createdDate: json['createdDate'] as String?,
      name: json['name'] as String?,
      nik: json['nik'] as String?,
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$GetUserReimburseDataToJson(
        GetUserReimburseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typeReimburse': instance.typeReimburse,
      'status': instance.status,
      'createdDate': instance.createdDate,
      'name': instance.name,
      'nik': instance.nik,
      'totalPrice': instance.totalPrice,
    };
