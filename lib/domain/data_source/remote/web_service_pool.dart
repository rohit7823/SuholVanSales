import 'package:get/get.dart';
import 'package:suhol_van_sales/domain/data_source/remote/login/response/user_onboarding_response.dart';
import 'package:suhol_van_sales/domain/data_source/remote/login/service/login_api.dart';
import 'package:suhol_van_sales/domain/di/rest_service.dart';
import 'package:suhol_van_sales/domain/models/user_onboarding.dart';
import 'package:suhol_van_sales/domain/utils/response.dart';

mixin WebServicePool {
  final httpClient = Get.find<RestService>();

  Future<RestResponse<UserOnboardingResponse>> login(
      UserOnboarding data) async {
    if (httpClient.instance == null) {
      return Error(message: "httpClient.instance is not ready");
    }

    return LoginApi(httpClient.instance!).signIn(data).then(
        (value) => Success(value),
        onError: (data) => Error(message: data.toString()));
  }
}
