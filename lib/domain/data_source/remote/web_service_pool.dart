import 'package:get/get.dart';
import 'package:suhol_van_sales/app/helpers/check_internet.dart';
import 'package:suhol_van_sales/domain/data_source/remote/customers/response/customers_with_locations_response.dart';
import 'package:suhol_van_sales/domain/data_source/remote/customers/service/customer_api.dart';
import 'package:suhol_van_sales/domain/data_source/remote/login/response/user_onboarding_response.dart';
import 'package:suhol_van_sales/domain/data_source/remote/login/service/login_api.dart';
import 'package:suhol_van_sales/domain/data_source/remote/logout/response/sign_out_user_response.dart';
import 'package:suhol_van_sales/domain/data_source/remote/logout/service/logout_api.dart';
import 'package:suhol_van_sales/domain/data_source/remote/material_request/request/material_requisition_request.dart';
import 'package:suhol_van_sales/domain/data_source/remote/material_request/service/material_request_api.dart';
import 'package:suhol_van_sales/domain/data_source/remote/products/response/products_response.dart';
import 'package:suhol_van_sales/domain/data_source/remote/products/service/products_api.dart';
import 'package:suhol_van_sales/domain/data_source/remote/user_details/response/user_details_response.dart';
import 'package:suhol_van_sales/domain/data_source/remote/user_details/service/user_details_api.dart';
import 'package:suhol_van_sales/domain/di/rest_service.dart';
import 'package:suhol_van_sales/domain/models/user_onboarding.dart';
import 'package:suhol_van_sales/domain/utils/response.dart';

import 'material_request/response/create_material_requisition.dart';

mixin WebServicePool {
  final httpClient = Get.find<RestService>();
  final connectivityService = Get.find<ConnectivityService>();
  final _noConnectivity = "No internet connectivity available.";

  Future<RestResponse<UserOnboardingResponse>> login(
      UserOnboarding data) async {
    if (httpClient.instance == null) {
      return Error(message: "httpClient.instance is not ready");
    }

    return await connectivityService.isConnected()
        ? LoginApi(httpClient.instance!).signIn(data).then(
            (value) => Success(value),
            onError: (data) =>
                Error<UserOnboardingResponse>(message: data.toString()))
        : Error(message: _noConnectivity);
  }

  Future<RestResponse<SignOutUserResponse>> logout() async {
    if (httpClient.instance == null) {
      return Error<SignOutUserResponse>(
          message: "httpClient.instance is not ready");
    }

    return await connectivityService.isConnected()
        ? LogoutApi(httpClient.instance!).signOut().then(
            (value) => Success(value),
            onError: (data) =>
                Error<SignOutUserResponse>(message: data.toString()))
        : Error(message: _noConnectivity);
  }

  Future<RestResponse<UserDetailsResponse>> userDetails() async {
    if (httpClient.instance == null) {
      return Error<UserDetailsResponse>(
          message: "httpClient.instance is not ready");
    }

    return await connectivityService.isConnected()
        ? UserDetailsApi(httpClient.instance!).details().then(
            (value) => Success(value),
            onError: (data) =>
                Error<UserDetailsResponse>(message: data.toString()))
        : Error(message: _noConnectivity);
  }

  Future<RestResponse<CustomersWithLocationResponse>>
      customersWithLocations() async {
    if (httpClient.instance == null) {
      return Error<CustomersWithLocationResponse>(
          message: "httpClient.instance is not ready");
    }

    return await connectivityService.isConnected()
        ? CustomerApi(httpClient.instance!).withLocations().then(
            (value) => Success(value),
            onError: (data) =>
                Error<CustomersWithLocationResponse>(message: data.toString()))
        : Error(message: _noConnectivity);
  }

  Future<RestResponse<CreateMaterialRequisitionResponse>>
      createMaterialRequisition(MaterialRequisitionRequest request) async {
    if (httpClient.instance == null) {
      return Error<CreateMaterialRequisitionResponse>(
          message: "httpClient.instance is not ready");
    }

    return await connectivityService.isConnected()
        ? MaterialRequestApi(httpClient.instance!)
            .createRequisition(request)
            .then((value) => Success(value),
                onError: (data) => Error<CustomersWithLocationResponse>(
                    message: data.toString()))
        : Error(message: _noConnectivity);
  }

  Future<RestResponse<CreateMaterialRequisitionResponse>>
      createMaterialRequisitionOrder(MaterialRequisitionRequest request) async {
    if (httpClient.instance == null) {
      return Error<CreateMaterialRequisitionResponse>(
          message: "httpClient.instance is not ready");
    }

    return await connectivityService.isConnected()
        ? MaterialRequestApi(httpClient.instance!)
            .createRequisitionOrder(request)
            .then((value) => Success(value),
                onError: (data) => Error<CustomersWithLocationResponse>(
                    message: data.toString()))
        : Error(message: _noConnectivity);
  }

  Future<RestResponse<ProductsResponse>> productsWithPackingAndUnits() async {
    if (httpClient.instance == null) {
      return Error<ProductsResponse>(
          message: "httpClient.instance is not ready");
    }

    return await connectivityService.isConnected()
        ? ProductsApi(httpClient.instance!).withPackingAndUnit().then(
            (value) => Success(value),
            onError: (data) =>
                Error<ProductsResponse>(message: data.toString()))
        : Error(message: _noConnectivity);
  }
}
