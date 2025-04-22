import 'dart:convert';

class ApprovedOrdersResponse {
  final bool? success;
  final String? message;
  final List<Order>? data;

  ApprovedOrdersResponse({
    this.success,
    this.message,
    this.data,
  });

  ApprovedOrdersResponse copyWith({
    bool? success,
    String? message,
    List<Order>? data,
  }) =>
      ApprovedOrdersResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ApprovedOrdersResponse.fromRawJson(String str) =>
      ApprovedOrdersResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApprovedOrdersResponse.fromJson(Map<String, dynamic> json) =>
      ApprovedOrdersResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Order>.from(json["data"]!.map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
      };
}

class Order {
  final String customerName;
  final String mobileNumber;
  final String productName;
  final String productPacking;
  final String productUnit;
  final String productQuantity;
  final String price;

  const Order({
    required this.customerName,
    required this.mobileNumber,
    required this.productName,
    required this.productPacking,
    required this.productUnit,
    required this.productQuantity,
    required this.price,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      customerName: json['customer']['name'] ?? 'No Value',
      mobileNumber: json['customer']["mobile_number"] ?? 'No Value',
      productName:
          json['customer']["product_name"] ?? json['product_name'] ?? 'No Value',
      productPacking:
          json['customer']["product_packing"] ?? json['product_packing'] ?? 'No Value',
      productUnit:
          json['customer']["product_unit"] ?? json['product_unit'] ?? 'No Value',
      productQuantity:
          (json['customer']["product_qty"] ?? json['product_qty'] ?? 'No Value')
              .toString(),
      price: (json['customer']["product_price"] ?? json['product_price'] ?? 'No Value')
          .toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "customerName": this.customerName,
      "mobileNumber": this.mobileNumber,
      "productName": this.productName,
      "productPacking": this.productPacking,
      "productUnit": this.productUnit,
      "productQuantity": this.productQuantity,
      "price": this.price,
    };
  }
}
