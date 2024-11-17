import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:suhol_van_sales/domain/data_source/remote/customers/response/customers_for_preorder.dart';

import '../response/customers_with_locations_response.dart';

part 'customer_api.g.dart';

@RestApi(parser: Parser.FlutterCompute)
abstract class CustomerApi {
  factory CustomerApi(Dio dio, {String? baseUrl}) = _CustomerApi;

  @GET("/customers-with-locations")
  Future<CustomersWithLocationResponse> withLocations();

  @GET("/material-requests/customer-list")
  Future<CustomersForPreorder> customersInsPreorder(
      @Query("pre_order_enabled") String preOrderEnabled,
      @Query("location-parents") String locationParents);
}
