import 'package:json_annotation/json_annotation.dart';

part 'employee_summary_response.g.dart';

// endpoint : reimburse/get-summary-reimburse
@JsonSerializable()
class EmployeeSummaryResponse {
  final bool success;
  final String msg;
  EmployeeSummaryData? data;

  EmployeeSummaryResponse({
    this.success = false,
    this.msg = '',
    this.data,
  });

  factory EmployeeSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$EmployeeSummaryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EmployeeSummaryResponseToJson(this);
}

@JsonSerializable()
class EmployeeSummaryData {
  final int onproceed;
  final int accepted;
  final int rejected;
  final int total_reimburse_this_year;

  EmployeeSummaryData({
    this.onproceed = 0,
    this.accepted = 0,
    this.rejected = 0,
    this.total_reimburse_this_year = 0,
  });

  factory EmployeeSummaryData.fromJson(Map<String, dynamic> json) =>
      _$EmployeeSummaryDataFromJson(json);
  Map<String, dynamic> toJson() => _$EmployeeSummaryDataToJson(this);
}
