// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_summary_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeSummaryResponse _$EmployeeSummaryResponseFromJson(
        Map<String, dynamic> json) =>
    EmployeeSummaryResponse(
      success: json['success'] as bool? ?? false,
      msg: json['msg'] as String? ?? '',
      data: json['data'] == null
          ? null
          : EmployeeSummaryData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EmployeeSummaryResponseToJson(
        EmployeeSummaryResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'msg': instance.msg,
      'data': instance.data,
    };

EmployeeSummaryData _$EmployeeSummaryDataFromJson(Map<String, dynamic> json) =>
    EmployeeSummaryData(
      onproceed: (json['onproceed'] as num?)?.toInt() ?? 0,
      accepted: (json['accepted'] as num?)?.toInt() ?? 0,
      rejected: (json['rejected'] as num?)?.toInt() ?? 0,
      total_reimburse_this_year:
          (json['total_reimburse_this_year'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$EmployeeSummaryDataToJson(
        EmployeeSummaryData instance) =>
    <String, dynamic>{
      'onproceed': instance.onproceed,
      'accepted': instance.accepted,
      'rejected': instance.rejected,
      'total_reimburse_this_year': instance.total_reimburse_this_year,
    };
