// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_condition_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TermConditionResponse _$TermConditionResponseFromJson(
        Map<String, dynamic> json) =>
    TermConditionResponse(
      success: json['success'] as bool? ?? false,
      msg: json['msg'] as String? ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((e) =>
                  TermConditionCategoryData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TermConditionResponseToJson(
        TermConditionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'msg': instance.msg,
      'data': instance.data,
    };

TermConditionCategoryData _$TermConditionCategoryDataFromJson(
        Map<String, dynamic> json) =>
    TermConditionCategoryData(
      category_reimbursement_id:
          (json['category_reimbursement_id'] as num?)?.toInt(),
      title: json['title'] as String? ?? '',
      list_tnc: (json['list_tnc'] as List<dynamic>?)
              ?.map(
                  (e) => TermConditionData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TermConditionCategoryDataToJson(
        TermConditionCategoryData instance) =>
    <String, dynamic>{
      'category_reimbursement_id': instance.category_reimbursement_id,
      'title': instance.title,
      'list_tnc': instance.list_tnc,
    };

TermConditionData _$TermConditionDataFromJson(Map<String, dynamic> json) =>
    TermConditionData(
      id: (json['id'] as num?)?.toInt(),
      tnc: json['tnc'] as String? ?? '',
    );

Map<String, dynamic> _$TermConditionDataToJson(TermConditionData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tnc': instance.tnc,
    };
