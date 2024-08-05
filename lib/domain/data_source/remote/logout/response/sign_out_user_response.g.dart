// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_out_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignOutUserResponse _$SignOutUserResponseFromJson(Map<String, dynamic> json) =>
    SignOutUserResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SignOutUserResponseToJson(
        SignOutUserResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
