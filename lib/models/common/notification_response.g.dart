// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListNotificationResponse _$ListNotificationResponseFromJson(Map<String, dynamic> json) =>
    ListNotificationResponse(
      success: json['success'] as bool? ?? false,
      msg: json['msg'] as String? ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => ItemNotificationData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ListNotificationResponseToJson(ListNotificationResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'msg': instance.msg,
      'data': instance.data,
    };

ItemNotificationData _$ItemNotificationDataFromJson(Map<String, dynamic> json) =>
    ItemNotificationData(
      title: json['title'] as String?,
      body: json['body'] as String?,
      categoryReimbursement: json['categoryReimbursement'] as String?,
      dateReimburse: json['dateReimburse'] as String?,
      reimburseId: (json['reimburseId'] as num?)?.toInt(),
      user: json['user'] as String?,
      identityNumber: json['identityNumber'] as String?,
      price: json['price'] as String?,
    );

Map<String, dynamic> _$ItemNotificationDataToJson(ItemNotificationData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'categoryReimbursement': instance.categoryReimbursement,
      'dateReimburse': instance.dateReimburse,
      'reimburseId': instance.reimburseId,
      'user': instance.user,
      'identityNumber': instance.identityNumber,
      'price': instance.price,
    };
