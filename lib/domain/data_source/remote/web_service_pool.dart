import 'package:get/get.dart';
import 'package:suhol_van_sales/domain/data_source/remote/customers/response/customers_with_locations_response.dart';
import 'package:suhol_van_sales/domain/data_source/remote/customers/service/customer_api.dart';
import 'package:suhol_van_sales/domain/data_source/remote/login/response/user_onboarding_response.dart';
import 'package:suhol_van_sales/domain/data_source/remote/login/service/login_api.dart';
import 'package:suhol_van_sales/domain/data_source/remote/logout/response/sign_out_user_response.dart';
import 'package:suhol_van_sales/domain/data_source/remote/logout/service/logout_api.dart';
import 'package:suhol_van_sales/domain/data_source/remote/user_details/response/user_details_response.dart';
import 'package:suhol_van_sales/domain/data_source/remote/user_details/service/user_details_api.dart';
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

    return await LoginApi(httpClient.instance!).signIn(data).then(
        (value) => Success(value),
        onError: (data) => Error<UserOnboardingResponse>(message: data.toString()));
  }

  Future<RestResponse<SignOutUserResponse>> logout() async {
    if (httpClient.instance == null) {
      return Error<SignOutUserResponse>(message: "httpClient.instance is not ready");
    }

    return LogoutApi(httpClient.instance!).signOut().then(
        (value) => Success(value),
        onError: (data) => Error<SignOutUserResponse>(
            message: data.toString()
        )
    );
  }

  Future<RestResponse<UserDetailsResponse>> userDetails() async {
    if (httpClient.instance == null) {
      return Error<UserDetailsResponse>(message: "httpClient.instance is not ready");
    }

    return UserDetailsApi(httpClient.instance!).details().then(
        (value) => Success(value),
        onError: (data) => Error<UserDetailsResponse>(message: data.toString()));
  }

  Future<RestResponse<CustomersWithLocationResponse>>
      customersWithLocations() async {
    if (httpClient.instance == null) {
      return Error<CustomersWithLocationResponse>(message: "httpClient.instance is not ready");
    }

    return CustomerApi(httpClient.instance!).withLocations().then(
        (value) => Success(value),
        onError: (data) => Error<CustomersWithLocationResponse>(message: data.toString()));
  }
}
