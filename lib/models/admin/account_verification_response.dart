import 'package:json_annotation/json_annotation.dart';

part 'account_verification_response.g.dart';

// endpoint : reimburse/get-current-status-active
@JsonSerializable()
class AccountVerificationResponse {
  final bool success;
  final String msg;
  List<AccountVerificationData>? data;

  AccountVerificationResponse({
    this.success = false,
    this.msg = '',
    this.data,
  });

  factory AccountVerificationResponse.fromJson(Map<String, dynamic> json) =>
      _$AccountVerificationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AccountVerificationResponseToJson(this);
}

@JsonSerializable()
class AccountVerificationData {
  final int? id;
  final String? nik;
  final String? name;
  final String? img_url;

  AccountVerificationData({
    this.id,
    this.nik,
    this.name,
    this.img_url,
  });

  factory AccountVerificationData.fromJson(Map<String, dynamic> json) =>
      _$AccountVerificationDataFromJson(json);
  Map<String, dynamic> toJson() => _$AccountVerificationDataToJson(this);
}
