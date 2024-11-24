import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:suhol_van_sales/domain/data_source/remote/division_management/response/division_list_response.dart';

part 'division_list_api.g.dart';

@RestApi(parser: Parser.FlutterCompute)
abstract class DivisionListApi {
  factory DivisionListApi(Dio dio, {String? baseUrl}) = _DivisionListApi;

  @GET("/material-requests/division-list")
  Future<DivisionListResponse> divisionList(@Query("division_name") String query);
}
