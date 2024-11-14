import 'package:json_annotation/json_annotation.dart';
import 'package:suhol_van_sales/domain/models/order.dart';


class LastMaterialOrdersResponse {
  final bool? success;
  final String? message;
  final List<Order>? data;

  const LastMaterialOrdersResponse({
    this.success,
    this.message,
    this.data,
  });

  factory LastMaterialOrdersResponse.fromJson(Map<String, dynamic> json) =>
      LastMaterialOrdersResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Order>.from(
            json["data"]!.map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };

}