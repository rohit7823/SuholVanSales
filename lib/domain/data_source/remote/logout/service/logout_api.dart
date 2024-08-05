import 'package:retrofit/http.dart';
import "package:retrofit/retrofit.dart";
import 'package:dio/dio.dart';

import '../response/sign_out_user_response.dart';

part "logout_api.g.dart";

@RestApi()
abstract class LogoutApi {
  factory LogoutApi(Dio dio, {String? baseUrl}) = _LogoutApi;

  @POST("/logout")
  Future<SignOutUserResponse> signOut();

  @POST("/logout-from-all")
  Future<SignOutUserResponse> signOutAll();
}
