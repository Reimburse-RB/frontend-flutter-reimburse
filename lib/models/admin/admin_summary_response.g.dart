// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_summary_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminSummaryResponse _$AdminSummaryResponseFromJson(
        Map<String, dynamic> json) =>
    AdminSummaryResponse(
      success: json['success'] as bool? ?? false,
      msg: json['msg'] as String? ?? '',
      data: json['data'] == null
          ? null
          : AdminSummaryData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdminSummaryResponseToJson(
        AdminSummaryResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'msg': instance.msg,
      'data': instance.data,
    };

AdminSummaryData _$AdminSummaryDataFromJson(Map<String, dynamic> json) =>
    AdminSummaryData(
      totalDiproses: (json['totalDiproses'] as num?)?.toInt() ?? 0,
      totalKesehatanDiproses:
          (json['totalKesehatanDiproses'] as num?)?.toInt() ?? 0,
      totalTrasnportDiproses:
          (json['totalTrasnportDiproses'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$AdminSummaryDataToJson(AdminSummaryData instance) =>
    <String, dynamic>{
      'totalDiproses': instance.totalDiproses,
      'totalKesehatanDiproses': instance.totalKesehatanDiproses,
      'totalTrasnportDiproses': instance.totalTrasnportDiproses,
    };
