import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:suhol_van_sales/domain/data_source/remote/approved_orders/response/approved_orders_response.dart';

part 'approved_orders_api.g.dart';

abstract class ApprovedOrdersApi {
  factory ApprovedOrdersApi(Dio dio, {String? baseUrl}) = _ApprovedOrdersApi;

  @GET("/material-requests/credit-sales-approved-orders")
  Future<ApprovedOrdersResponse> creditSalesApprovedOrders(
      @Header("Authorization") String token);

  @GET("/material-requests/cash-sales-approved-orders")
  Future<ApprovedOrdersResponse> cashSalesApprovedOrders(
      @Header("Authorization") String token);
}
