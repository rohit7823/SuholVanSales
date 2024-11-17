import 'package:json_annotation/json_annotation.dart';

part 'pre_orders_response.g.dart';

@JsonSerializable()
class PreOrdersResponse {
  final bool? success;
  final String? message;
  final List<dynamic>? data;

  const PreOrdersResponse({
    this.success,
    this.message,
    this.data,
  });

  factory PreOrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$PreOrdersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PreOrdersResponseToJson(this);
}
