// To parse this JSON data, do
//
//     final customerList = customerListFromMap(jsonString);

import 'dart:convert';

import 'package:suhol_van_sales/domain/models/customer.dart';

CustomersForPreorder deserializeCustomersForPreorder(
        Map<String, dynamic> str) =>
    CustomersForPreorder.fromMap(str);

String serializeCustomersForPreorder(CustomersForPreorder data) =>
    json.encode(data.toMap());

class CustomersForPreorder {
  final bool? success;
  final String? message;
  final List<Customer>? data;

  CustomersForPreorder({
    this.success,
    this.message,
    this.data,
  });

  CustomersForPreorder copyWith({
    bool? success,
    String? message,
    List<Customer>? data,
  }) =>
      CustomersForPreorder(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory CustomersForPreorder.fromMap(Map<String, dynamic> json) =>
      CustomersForPreorder(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Customer>.from(
                json["data"]!.map((x) => Customer.fromJson(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<Customer>.from(data!.map((x) => x.toJson())),
      };
}
