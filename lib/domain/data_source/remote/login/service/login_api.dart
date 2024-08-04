import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:suhol_van_sales/domain/data_source/remote/login/response/user_onboarding_response.dart';
import 'package:suhol_van_sales/domain/models/user_onboarding.dart';

part 'login_api.g.dart';

@RestApi()
abstract class LoginApi {
  factory LoginApi(Dio dio, {String? baseUrl}) = _LoginApi;

  @POST("/login")
  Future<UserOnboardingResponse> signIn(@Body() UserOnboarding data);
}
