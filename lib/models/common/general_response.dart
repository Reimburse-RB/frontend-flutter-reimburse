import 'package:json_annotation/json_annotation.dart';

part 'general_response.g.dart';

// endpoint : user/register
@JsonSerializable()
class GeneralResponse {
  final bool success;
  final String msg;

  GeneralResponse({
    this.success = false,
    this.msg = '',
  });

  factory GeneralResponse.fromJson(Map<String, dynamic> json) => _$GeneralResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GeneralResponseToJson(this);
}
