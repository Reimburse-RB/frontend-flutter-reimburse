import 'package:json_annotation/json_annotation.dart';
import 'package:reimburse_rb/models/common/auth_response.dart';

part 'profile_response.g.dart';

// endpoint : user/get-profile
@JsonSerializable()
class ProfileResponse {
  final bool success;
  final String msg;
  ProfileData? data;

  ProfileResponse({
    this.success = false,
    this.msg = '',
    this.data,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => _$ProfileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}

// endpoint : user/edit-profile
@JsonSerializable()
class EditProfileResponse {
  final bool success;
  final String msg;
  AuthUserData? data;

  EditProfileResponse({
    this.success = false,
    this.msg = '',
    this.data,
  });

  factory EditProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$EditProfileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EditProfileResponseToJson(this);
}

@JsonSerializable()
class ProfileData {
  final String nik;
  final String name;
  final String email;
  final int? role_id;
  final String role_text;
  bool is_account_verified;
  String? img_url;
  List<FamilyMemberData> family_member_data;

  ProfileData({
    this.nik = '',
    this.name = '',
    this.email = '',
    this.role_id,
    this.is_account_verified = false,
    this.role_text = '',
    this.img_url,
    this.family_member_data = const [],
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => _$ProfileDataFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileDataToJson(this);
}

@JsonSerializable()
class FamilyMemberData {
  final int? id;
  int? family_status_id;
  String family_status_text;
  String name;

  FamilyMemberData({
    this.id,
    this.family_status_id,
    this.family_status_text = '',
    this.name = '',
  });

  factory FamilyMemberData.fromJson(Map<String, dynamic> json) => _$FamilyMemberDataFromJson(json);
  Map<String, dynamic> toJson() => _$FamilyMemberDataToJson(this);
}

@JsonSerializable()
class FamilyMemberOption {
  final int? family_status_id;
  final String family_status_text;

  FamilyMemberOption({
    required this.family_status_id,
    required this.family_status_text,
  });

  factory FamilyMemberOption.fromJson(Map<String, dynamic> json) =>
      _$FamilyMemberOptionFromJson(json);
  Map<String, dynamic> toJson() => _$FamilyMemberOptionToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FamilyMemberOption &&
          runtimeType == other.runtimeType &&
          family_status_id == other.family_status_id &&
          family_status_text == other.family_status_text;

  @override
  int get hashCode => family_status_id.hashCode ^ family_status_text.hashCode;
}
