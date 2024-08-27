import 'package:json_annotation/json_annotation.dart';

part 'recapitulation_response.g.dart';

// endpoint : reimburse/get-list-purpose-option
@JsonSerializable()
class RecapitulationPeriodResponse {
  final bool success;
  final String msg;
  List<String>? data;

  RecapitulationPeriodResponse({
    this.success = false,
    this.msg = '',
    this.data = const [],
  });

  factory RecapitulationPeriodResponse.fromJson(Map<String, dynamic> json) =>
      _$RecapitulationPeriodResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RecapitulationPeriodResponseToJson(this);
}
