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

@JsonSerializable()
class AddReimbursementResponse {
  final bool success;
  final String msg;
  AddReimbursementData? data;

  AddReimbursementResponse({
    this.success = false,
    this.msg = '',
    this.data,
  });

  factory AddReimbursementResponse.fromJson(Map<String, dynamic> json) =>
      _$AddReimbursementResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AddReimbursementResponseToJson(this);
}

@JsonSerializable()
class AddReimbursementData {
  final int? status;
  final int? id;
  final int? purpose_id;
  final String? purpose_other;
  final int? user_id;
  final int? category;
  final String? updatedAt;
  final String? createdAt;

  AddReimbursementData({
    this.status,
    this.id,
    this.purpose_id,
    this.purpose_other,
    this.user_id,
    this.category,
    this.updatedAt,
    this.createdAt,
  });

  factory AddReimbursementData.fromJson(Map<String, dynamic> json) =>
      _$AddReimbursementDataFromJson(json);
  Map<String, dynamic> toJson() => _$AddReimbursementDataToJson(this);
}
