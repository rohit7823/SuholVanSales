import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:suhol_van_sales/domain/models/product.dart';

part 'products_response.g.dart';

FutureOr<ProductsResponse> deserializeProductsResponse(
        Map<String, dynamic> str) =>
    ProductsResponse.fromJson(str);

FutureOr<Map<String, dynamic>> serializeProductsResponse(
        ProductsResponse data) =>
    data.toJson();

@JsonSerializable()
class ProductsResponse {
  final bool? success;
  final String? message;
  final List<Product>? data;

  const ProductsResponse({
    this.success,
    this.message,
    this.data,
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsResponseToJson(this);
}
