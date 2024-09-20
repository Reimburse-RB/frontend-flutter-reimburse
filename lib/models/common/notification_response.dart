import 'package:json_annotation/json_annotation.dart';

part 'notification_response.g.dart';

// endpoint : notification/get-list-notification
@JsonSerializable()
class ListNotificationResponse {
  final bool success;
  final String msg;
  List<ItemNotificationData> data;

  ListNotificationResponse({
    this.success = false,
    this.msg = '',
    this.data = const [],
  });

  factory ListNotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$ListNotificationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ListNotificationResponseToJson(this);
}

@JsonSerializable()
class ItemNotificationData {
  final String? title;
  final String? body;
  final String? categoryReimbursement;
  final String? dateReimburse;
  final int? reimburseId;
  final String? user;
  final String? identityNumber;
  final String? price;

  ItemNotificationData({
    this.title,
    this.body,
    this.categoryReimbursement,
    this.dateReimburse,
    this.reimburseId,
    this.user,
    this.identityNumber,
    this.price,
  });

  factory ItemNotificationData.fromJson(Map<String, dynamic> json) =>
      _$ItemNotificationDataFromJson(json);
  Map<String, dynamic> toJson() => _$ItemNotificationDataToJson(this);
}
