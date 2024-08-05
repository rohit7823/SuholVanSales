
import 'package:flutter/foundation.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

import '../response/customers_with_locations_response.dart';

part 'customer_api.g.dart';

@RestApi(parser: Parser.FlutterCompute)
abstract class CustomerApi {

  factory CustomerApi(Dio dio, {String? baseUrl}) = _CustomerApi;

  @GET("/customers-with-locations")
  Future<CustomersWithLocationResponse> withLocations();

}