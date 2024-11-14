// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_orders_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreOrdersResponse _$PreOrderResponseFromJson(Map<String, dynamic> json) =>
    PreOrdersResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] as List<dynamic>?,
    );

Map<String, dynamic> _$PreOrderResponseToJson(PreOrdersResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
