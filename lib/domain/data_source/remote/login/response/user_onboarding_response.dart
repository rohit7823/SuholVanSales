import 'package:json_annotation/json_annotation.dart';
import 'package:suhol_van_sales/domain/utils/business_object.dart';

part 'user_onboarding_response.g.dart';

@JsonSerializable()
class UserOnboardingResponse extends BusinessObject {
  @JsonKey(name: "status")
  final bool? status;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "token")
  final String? token;

  UserOnboardingResponse({
    this.status,
    this.message,
    this.token,
  });

  UserOnboardingResponse copyWith({
    bool? status,
    String? message,
    String? token,
  }) =>
      UserOnboardingResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        token: token ?? this.token,
      );

  factory UserOnboardingResponse.fromJson(Map<String, dynamic> json) =>
      _$UserOnboardingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserOnboardingResponseToJson(this);
}
