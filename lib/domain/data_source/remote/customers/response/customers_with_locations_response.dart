import 'dart:async';

import '../../../../models/customer.dart';

FutureOr<CustomersWithLocationResponse>
    deserializeCustomersWithLocationResponse(Map<String, dynamic> str) =>
        CustomersWithLocationResponse.fromJson(str);

FutureOr<Map<String, dynamic>> serializeCustomersWithLocationResponse(
        CustomersWithLocationResponse data) =>
    data.toJson();

class CustomersWithLocationResponse {
  final bool? success;
  final String? message;
  final List<Customer>? customers;

  CustomersWithLocationResponse({
    this.success,
    this.message,
    this.customers,
  });

  CustomersWithLocationResponse copyWith({
    bool? success,
    String? message,
    List<Customer>? customers,
  }) =>
      CustomersWithLocationResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        customers: customers ?? this.customers,
      );

  factory CustomersWithLocationResponse.fromJson(Map<String, dynamic> json) =>
      CustomersWithLocationResponse(
        success: json["success"],
        message: json["message"],
        customers: json["data"] == null
            ? []
            : List<Customer>.from(
                json["data"]!.map((x) => Customer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": customers == null
            ? []
            : List<dynamic>.from(customers!.map((x) => x.toJson())),
      };
}
