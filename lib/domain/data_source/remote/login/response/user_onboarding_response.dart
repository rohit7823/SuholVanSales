import 'package:json_annotation/json_annotation.dart';
import 'package:suhol_van_sales/domain/data_source/remote/login/response/app_icon.dart';
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
  @JsonKey(name: "app_icons")
  final List<AppIcon>? appIcons;

  UserOnboardingResponse({
    this.status,
    this.message,
    this.token,
    this.appIcons
  });

  UserOnboardingResponse copyWith({
    bool? status,
    String? message,
    String? token,
    List<AppIcon>? appIcons
  }) =>
      UserOnboardingResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        token: token ?? this.token,
        appIcons: appIcons ?? this.appIcons
      );

  factory UserOnboardingResponse.fromJson(Map<String, dynamic> json) =>
      _$UserOnboardingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserOnboardingResponseToJson(this);
}
