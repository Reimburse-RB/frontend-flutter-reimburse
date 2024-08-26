import 'package:json_annotation/json_annotation.dart';

part 'admin_summary_response.g.dart';

// endpoint : reimburse/get-current-status-active
@JsonSerializable()
class AdminSummaryResponse {
  final bool success;
  final String msg;
  AdminSummaryData? data;

  AdminSummaryResponse({
    this.success = false,
    this.msg = '',
    this.data,
  });

  factory AdminSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminSummaryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AdminSummaryResponseToJson(this);
}

@JsonSerializable()
class AdminSummaryData {
  final int totalDiproses;
  final int totalKesehatanDiproses;
  final int totalTrasnportDiproses;

  AdminSummaryData({
    this.totalDiproses = 0,
    this.totalKesehatanDiproses = 0,
    this.totalTrasnportDiproses = 0,
  });

  factory AdminSummaryData.fromJson(Map<String, dynamic> json) => _$AdminSummaryDataFromJson(json);
  Map<String, dynamic> toJson() => _$AdminSummaryDataToJson(this);
}
