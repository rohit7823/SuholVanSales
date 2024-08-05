import 'package:json_annotation/json_annotation.dart';

part 'sign_out_user_response.g.dart';

@JsonSerializable()
class SignOutUserResponse {
  @JsonKey(name: "status")
  final bool? status;
  @JsonKey(name: "message")
  final String? message;

  SignOutUserResponse({
    this.status,
    this.message,
  });

  SignOutUserResponse copyWith({
    bool? status,
    String? message,
  }) =>
      SignOutUserResponse(
        status: status ?? this.status,
        message: message ?? this.message,
      );

  factory SignOutUserResponse.fromJson(Map<String, dynamic> json) => _$SignOutUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignOutUserResponseToJson(this);
}
