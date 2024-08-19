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
class ListUserReimburseResponse {
  final bool success;
  final String msg;
  List<ItemUserReimburseData>? data;

  ListUserReimburseResponse({
    this.success = false,
    this.msg = '',
    this.data,
  });

  factory ListUserReimburseResponse.fromJson(Map<String, dynamic> json) =>
      _$ListUserReimburseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ListUserReimburseResponseToJson(this);
}

@JsonSerializable()
class ItemUserReimburseData {
  final int? id;
  final int? statusId;
  final String? typeReimburse;
  final String? status;
  final String? createdDate;
  final String? name;
  final String? nik;
  final double? totalPrice;

  ItemUserReimburseData({
    this.id,
    this.statusId,
    this.typeReimburse,
    this.status,
    this.createdDate,
    this.name,
    this.nik,
    this.totalPrice,
  });

  factory ItemUserReimburseData.fromJson(Map<String, dynamic> json) =>
      _$ItemUserReimburseDataFromJson(json);
  Map<String, dynamic> toJson() => _$ItemUserReimburseDataToJson(this);
}

// endpoint : reimburse/get-detail-reimburse
@JsonSerializable()
class DetailReimburseResponse {
  final bool success;
  final String msg;
  DetailReimburseData? data;

  DetailReimburseResponse({
    this.success = false,
    this.msg = '',
    this.data,
  });

  factory DetailReimburseResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailReimburseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DetailReimburseResponseToJson(this);
}

@JsonSerializable()
class DetailReimburseData {
  final String? name;
  final String? email;
  final String? nik;
  final int? status_id;
  final String? status_text;
  final int? category_reimbursement_id;
  final String? category_reimbursement_text;
  final int? purpose_id;
  final String? purpose_text;
  final String? date;
  final double? totalPrice;
  List<ItemAttachmentData>? list_attachment;
  List<ItemDetailReimburseData>? detailReimburse;

  DetailReimburseData({
    this.name,
    this.email,
    this.nik,
    this.status_id,
    this.status_text,
    this.category_reimbursement_id,
    this.category_reimbursement_text,
    this.purpose_id,
    this.purpose_text,
    this.date,
    this.totalPrice,
    this.list_attachment,
    this.detailReimburse,
  });

  factory DetailReimburseData.fromJson(Map<String, dynamic> json) =>
      _$DetailReimburseDataFromJson(json);
  Map<String, dynamic> toJson() => _$DetailReimburseDataToJson(this);
}

@JsonSerializable()
class ItemAttachmentData {
  final int? id;
  final String? image;

  ItemAttachmentData({
    this.id,
    this.image,
  });

  factory ItemAttachmentData.fromJson(Map<String, dynamic> json) =>
      _$ItemAttachmentDataFromJson(json);
  Map<String, dynamic> toJson() => _$ItemAttachmentDataToJson(this);
}

@JsonSerializable()
class ItemDetailReimburseData {
  final int? detail_id;
  final int? detail_title_id;
  final String? detail_title_text;
  final int? detail_family_id;
  final String? detail_family_name;
  final double? detail_cost;
  final String? detail_date;
  final String? detail_desc;

  ItemDetailReimburseData({
    this.detail_id,
    this.detail_title_id,
    this.detail_title_text,
    this.detail_family_id,
    this.detail_family_name,
    this.detail_cost,
    this.detail_date,
    this.detail_desc,
  });

  factory ItemDetailReimburseData.fromJson(Map<String, dynamic> json) =>
      _$ItemDetailReimburseDataFromJson(json);
  Map<String, dynamic> toJson() => _$ItemDetailReimburseDataToJson(this);
}

// endpoint : reimburse/change-status-reimburse
@JsonSerializable()
class ChangeStatusReimburseResponse {
  final bool success;
  final String msg;
  AddReimburseData? data;

  ChangeStatusReimburseResponse({
    this.success = false,
    this.msg = '',
    this.data,
  });

  factory ChangeStatusReimburseResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangeStatusReimburseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ChangeStatusReimburseResponseToJson(this);
}
