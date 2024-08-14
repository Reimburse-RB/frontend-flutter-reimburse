import 'package:json_annotation/json_annotation.dart';

part 'term_condition_response.g.dart';

// endpoint : tnc/get-tnc
@JsonSerializable()
class TermConditionResponse {
  final bool success;
  final String msg;
  List<TermConditionCategoryData> data;

  TermConditionResponse({
    this.success = false,
    this.msg = '',
    this.data = const [],
  });

  factory TermConditionResponse.fromJson(Map<String, dynamic> json) =>
      _$TermConditionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TermConditionResponseToJson(this);
}

@JsonSerializable()
class TermConditionCategoryData {
  final int? category_reimbursement_id;
  final String title;
  List<TermConditionData> list_tnc;

  TermConditionCategoryData({
    this.category_reimbursement_id,
    this.title = '',
    this.list_tnc = const [],
  });

  factory TermConditionCategoryData.fromJson(Map<String, dynamic> json) =>
      _$TermConditionCategoryDataFromJson(json);
  Map<String, dynamic> toJson() => _$TermConditionCategoryDataToJson(this);
}

@JsonSerializable()
class TermConditionData {
  int? id;
  String tnc;

  TermConditionData({
    this.id,
    this.tnc = '',
  });

  factory TermConditionData.fromJson(Map<String, dynamic> json) =>
      _$TermConditionDataFromJson(json);
  Map<String, dynamic> toJson() => _$TermConditionDataToJson(this);
}
