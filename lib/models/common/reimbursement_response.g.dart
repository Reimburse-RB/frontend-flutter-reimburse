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

ListUserReimburseResponse _$ListUserReimburseResponseFromJson(
        Map<String, dynamic> json) =>
    ListUserReimburseResponse(
      success: json['success'] as bool? ?? false,
      msg: json['msg'] as String? ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => ItemUserReimburseData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListUserReimburseResponseToJson(
        ListUserReimburseResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'msg': instance.msg,
      'data': instance.data,
    };

ItemUserReimburseData _$ItemUserReimburseDataFromJson(
        Map<String, dynamic> json) =>
    ItemUserReimburseData(
      id: (json['id'] as num?)?.toInt(),
      statusId: (json['statusId'] as num?)?.toInt(),
      typeReimburse: json['typeReimburse'] as String?,
      status: json['status'] as String?,
      createdDate: json['createdDate'] as String?,
      name: json['name'] as String?,
      nik: json['nik'] as String?,
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ItemUserReimburseDataToJson(
        ItemUserReimburseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'statusId': instance.statusId,
      'typeReimburse': instance.typeReimburse,
      'status': instance.status,
      'createdDate': instance.createdDate,
      'name': instance.name,
      'nik': instance.nik,
      'totalPrice': instance.totalPrice,
    };

DetailReimburseResponse _$DetailReimburseResponseFromJson(
        Map<String, dynamic> json) =>
    DetailReimburseResponse(
      success: json['success'] as bool? ?? false,
      msg: json['msg'] as String? ?? '',
      data: json['data'] == null
          ? null
          : DetailReimburseData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DetailReimburseResponseToJson(
        DetailReimburseResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'msg': instance.msg,
      'data': instance.data,
    };

DetailReimburseData _$DetailReimburseDataFromJson(Map<String, dynamic> json) =>
    DetailReimburseData(
      name: json['name'] as String?,
      email: json['email'] as String?,
      nik: json['nik'] as String?,
      status_id: (json['status_id'] as num?)?.toInt(),
      status_text: json['status_text'] as String?,
      category_reimbursement_id:
          (json['category_reimbursement_id'] as num?)?.toInt(),
      category_reimbursement_text:
          json['category_reimbursement_text'] as String?,
      purpose_id: (json['purpose_id'] as num?)?.toInt(),
      purpose_text: json['purpose_text'] as String?,
      date: json['date'] as String?,
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      list_attachment: (json['list_attachment'] as List<dynamic>?)
          ?.map((e) => ItemAttachmentData.fromJson(e as Map<String, dynamic>))
          .toList(),
      detailReimburse: (json['detailReimburse'] as List<dynamic>?)
          ?.map((e) =>
              ItemDetailReimburseData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DetailReimburseDataToJson(
        DetailReimburseData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'nik': instance.nik,
      'status_id': instance.status_id,
      'status_text': instance.status_text,
      'category_reimbursement_id': instance.category_reimbursement_id,
      'category_reimbursement_text': instance.category_reimbursement_text,
      'purpose_id': instance.purpose_id,
      'purpose_text': instance.purpose_text,
      'date': instance.date,
      'totalPrice': instance.totalPrice,
      'list_attachment': instance.list_attachment,
      'detailReimburse': instance.detailReimburse,
    };

ItemAttachmentData _$ItemAttachmentDataFromJson(Map<String, dynamic> json) =>
    ItemAttachmentData(
      id: (json['id'] as num?)?.toInt(),
      image: json['image'] as String?,
    );

Map<String, dynamic> _$ItemAttachmentDataToJson(ItemAttachmentData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
    };

ItemDetailReimburseData _$ItemDetailReimburseDataFromJson(
        Map<String, dynamic> json) =>
    ItemDetailReimburseData(
      detail_id: (json['detail_id'] as num?)?.toInt(),
      detail_title_id: (json['detail_title_id'] as num?)?.toInt(),
      detail_title_text: json['detail_title_text'] as String?,
      detail_family_id: (json['detail_family_id'] as num?)?.toInt(),
      detail_family_name: json['detail_family_name'] as String?,
      detail_cost: (json['detail_cost'] as num?)?.toDouble(),
      detail_date: json['detail_date'] as String?,
      detail_desc: json['detail_desc'] as String?,
    );

Map<String, dynamic> _$ItemDetailReimburseDataToJson(
        ItemDetailReimburseData instance) =>
    <String, dynamic>{
      'detail_id': instance.detail_id,
      'detail_title_id': instance.detail_title_id,
      'detail_title_text': instance.detail_title_text,
      'detail_family_id': instance.detail_family_id,
      'detail_family_name': instance.detail_family_name,
      'detail_cost': instance.detail_cost,
      'detail_date': instance.detail_date,
      'detail_desc': instance.detail_desc,
    };

ChangeStatusReimburseResponse _$ChangeStatusReimburseResponseFromJson(
        Map<String, dynamic> json) =>
    ChangeStatusReimburseResponse(
      success: json['success'] as bool? ?? false,
      msg: json['msg'] as String? ?? '',
      data: json['data'] == null
          ? null
          : AddReimburseData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChangeStatusReimburseResponseToJson(
        ChangeStatusReimburseResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'msg': instance.msg,
      'data': instance.data,
    };
