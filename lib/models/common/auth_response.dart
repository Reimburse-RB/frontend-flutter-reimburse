import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class SignUpResponse {
  final bool success;
  final String msg;
  AuthUserData? data;

  SignUpResponse({
    this.success = false,
    this.msg = '',
    this.data,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => _$SignUpResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpResponseToJson(this);
}

@JsonSerializable()
class SignInResponse {
  final bool success;
  final String msg;
  final String token;
  final AuthUserData? user;

  SignInResponse({
    this.success = false,
    this.msg = '',
    this.token = '',
    this.user,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) => _$SignInResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SignInResponseToJson(this);
}

@JsonSerializable()
class AuthUserData {
  final int? id;
  final String? fullname;
  final String? email;
  final String? password;
  final String? identity_number;
  final int? role;
  final String? token;
  final int? status;
  final String? image_url;
  final String? created_at;
  final String? updated_at;

  AuthUserData({
    this.id,
    this.fullname,
    this.email,
    this.password,
    this.identity_number,
    this.role,
    this.token,
    this.status,
    this.image_url,
    this.created_at,
    this.updated_at,
  });

  factory AuthUserData.fromJson(Map<String, dynamic> json) => _$AuthUserDataFromJson(json);
  Map<String, dynamic> toJson() => _$AuthUserDataToJson(this);
}
