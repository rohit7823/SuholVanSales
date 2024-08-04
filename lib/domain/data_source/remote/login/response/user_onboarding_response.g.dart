// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_onboarding_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserOnboardingResponse _$UserOnboardingResponseFromJson(
        Map<String, dynamic> json) =>
    UserOnboardingResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$UserOnboardingResponseToJson(
        UserOnboardingResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'token': instance.token,
    };
