// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recapitulation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecapitulationPeriodResponse _$RecapitulationPeriodResponseFromJson(
        Map<String, dynamic> json) =>
    RecapitulationPeriodResponse(
      success: json['success'] as bool? ?? false,
      msg: json['msg'] as String? ?? '',
      data:
          (json['data'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$RecapitulationPeriodResponseToJson(
        RecapitulationPeriodResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'msg': instance.msg,
      'data': instance.data,
    };
