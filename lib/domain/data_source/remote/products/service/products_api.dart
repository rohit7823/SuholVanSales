import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/http.dart';
import 'package:suhol_van_sales/domain/data_source/remote/products/response/products_response.dart';

part 'products_api.g.dart';

@RestApi(parser: Parser.FlutterCompute)
abstract class ProductsApi {
  factory ProductsApi(Dio dio, {String? baseUrl}) = _ProductsApi;

  @GET("/product/fetch-product-with-packing-and-unit")
  Future<ProductsResponse> withPackingAndUnit();
}
