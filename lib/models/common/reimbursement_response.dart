import 'package:json_annotation/json_annotation.dart';

part 'reimbursement_response.g.dart';

class ReimbursementCategoryData {
  ReimbursementCategoryData({
    required this.categoryReimbursementId,
    required this.categoryReimbursementText,
  });
  late final int categoryReimbursementId;
  late final String categoryReimbursementText;
}

// endpoint : reimburse/get-list-purpose-option
@JsonSerializable()
class PurposeOptionResponse {
  final bool success;
  final String msg;
  List<PurposeOptionData>? data;

  PurposeOptionResponse({
    this.success = false,
    this.msg = '',
    this.data = const [],
  });

  factory PurposeOptionResponse.fromJson(Map<String, dynamic> json) =>
      _$PurposeOptionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PurposeOptionResponseToJson(this);
}

@JsonSerializable()
class PurposeOptionData {
  final int? purpose_id;
  final String? purpose_text;

  PurposeOptionData({
    this.purpose_id,
    this.purpose_text,
  });

  factory PurposeOptionData.fromJson(Map<String, dynamic> json) =>
      _$PurposeOptionDataFromJson(json);
  Map<String, dynamic> toJson() => _$PurposeOptionDataToJson(this);
}

// endpoint : reimburse/get-list-detail-title-option
@JsonSerializable()
class DetailCostOptionResponse {
  final bool success;
  final String msg;
  List<DetailCostOptionData> data;

  DetailCostOptionResponse({
    this.success = false,
    this.msg = '',
    this.data = const [],
  });

  factory DetailCostOptionResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailCostOptionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DetailCostOptionResponseToJson(this);
}

@JsonSerializable()
class DetailCostOptionData {
  final int? detail_title_id;
  final String? detail_title_text;

  DetailCostOptionData({
    this.detail_title_id,
    this.detail_title_text,
  });

  factory DetailCostOptionData.fromJson(Map<String, dynamic> json) =>
      _$DetailCostOptionDataFromJson(json);
  Map<String, dynamic> toJson() => _$DetailCostOptionDataToJson(this);
}

// endpoint : reimburse/add-reimburse
@JsonSerializable()
class AddReimburseResponse {
  final bool success;
  final String msg;
  AddReimburseData? data;

  AddReimburseResponse({
    this.success = false,
    this.msg = '',
    this.data,
  });

  factory AddReimburseResponse.fromJson(Map<String, dynamic> json) =>
      _$AddReimburseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AddReimburseResponseToJson(this);
}

@JsonSerializable()
class AddReimburseData {
  final int? status;
  final int? id;
  final int? purpose_id;
  final String? purpose_other;
  final int? user_id;
  final int? category;
  final String? updatedAt;
  final String? createdAt;

  AddReimburseData({
    this.status,
    this.id,
    this.purpose_id,
    this.purpose_other,
    this.user_id,
    this.category,
    this.updatedAt,
    this.createdAt,
  });

  factory AddReimburseData.fromJson(Map<String, dynamic> json) => _$AddReimburseDataFromJson(json);
  Map<String, dynamic> toJson() => _$AddReimburseDataToJson(this);
}

// endpoint : reimburse/get-user-reimburse
@JsonSerializable()
class GetUserReimburseResponse {
  final bool success;
  final String msg;
  GetUserReimburseData? data;

  GetUserReimburseResponse({
    this.success = false,
    this.msg = '',
    this.data,
  });

  factory GetUserReimburseResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUserReimburseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetUserReimburseResponseToJson(this);
}

@JsonSerializable()
class GetUserReimburseData {
  final int? id;
  final String? typeReimbursement;
  final String? status;
  final String? createdDate;
  final String? name;
  final String? nik;
  final double? totalPrice;

  GetUserReimburseData({
    this.id,
    this.typeReimbursement,
    this.status,
    this.createdDate,
    this.name,
    this.nik,
    this.totalPrice,
  });

  factory GetUserReimburseData.fromJson(Map<String, dynamic> json) =>
      _$GetUserReimburseDataFromJson(json);
  Map<String, dynamic> toJson() => _$GetUserReimburseDataToJson(this);
}
