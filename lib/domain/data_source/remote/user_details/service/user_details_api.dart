import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:suhol_van_sales/domain/data_source/remote/user_details/response/user_details_response.dart';

part 'user_details_api.g.dart';

@RestApi()
abstract class UserDetailsApi {
  factory UserDetailsApi(Dio dio, {String? baseUrl}) = _UserDetailsApi;

  @GET("/user")
  Future<UserDetailsResponse> details();
}
