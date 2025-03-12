import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/app/helpers/check_internet.dart';
import 'package:suhol_van_sales/domain/data_source/remote/customers/response/customers_with_locations_response.dart';
import 'package:suhol_van_sales/domain/data_source/remote/customers/service/customer_api.dart';
import 'package:suhol_van_sales/domain/data_source/remote/division_management/response/division_list_response.dart';
import 'package:suhol_van_sales/domain/data_source/remote/division_management/service/division_list_api.dart';
import 'package:suhol_van_sales/domain/data_source/remote/login/response/user_onboarding_response.dart';
import 'package:suhol_van_sales/domain/data_source/remote/login/service/login_api.dart';
import 'package:suhol_van_sales/domain/data_source/remote/logout/response/sign_out_user_response.dart';
import 'package:suhol_van_sales/domain/data_source/remote/logout/service/logout_api.dart';
import 'package:suhol_van_sales/domain/data_source/remote/material_request/request/material_requisition_request.dart';
import 'package:suhol_van_sales/domain/data_source/remote/material_request/response/last_material_orders_response.dart';
import 'package:suhol_van_sales/domain/data_source/remote/material_request/service/material_request_api.dart';
import 'package:suhol_van_sales/domain/data_source/remote/pre_order/response/pre_orders_response.dart';
import 'package:suhol_van_sales/domain/data_source/remote/pre_order/service/pre_order_list_api.dart';
import 'package:suhol_van_sales/domain/data_source/remote/products/response/products_response.dart';
import 'package:suhol_van_sales/domain/data_source/remote/products/service/products_api.dart';
import 'package:suhol_van_sales/domain/data_source/remote/user_details/response/user_details_response.dart';
import 'package:suhol_van_sales/domain/data_source/remote/user_details/service/user_details_api.dart';
import 'package:suhol_van_sales/domain/di/rest_service.dart';
import 'package:suhol_van_sales/domain/models/user_onboarding.dart';
import 'package:suhol_van_sales/domain/utils/response.dart';

import 'customers/response/customers_for_preorder.dart';
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
        ? CustomerApi(httpClient.instance!)
            .withLocations()
            .then((value) => Success(value), onError: (data) {
            log(data.toString(), name: "CUSTOMERS_ERROR");
            return Error<CustomersWithLocationResponse>(
                message: data.toString());
          })
        : Error(message: _noConnectivity);
  }

  Future<RestResponse<CreateMaterialRequisitionResponse>>
      createMaterialRequisition(MaterialRequisitionRequest request) async {
    if (httpClient.instance == null) {
      return Error<CreateMaterialRequisitionResponse>(
          message: "httpClient.instance is not ready");
    }

    return await connectivityService.isConnected()
        ? MaterialRequestApi(httpClient.instance!,
                errorLogger: httpClient.logger)
            .createRequisition(request)
            .then((value) => Success(value),
                onError: (data) => Error<CustomersWithLocationResponse>(
                    message: data.toString()))
        : Error(message: _noConnectivity);
  }

  Future<RestResponse<CreateMaterialRequisitionResponse>> createMaterialReq(
      MaterialRequisitionRequest request) async {
    if (httpClient.instance == null) {
      return Error<CreateMaterialRequisitionResponse>(
          message: "httpClient.instance is not ready");
    }

    return await connectivityService.isConnected()
        ? MaterialRequestApi(httpClient.instance!,
                errorLogger: httpClient.logger)
            .createMrOrder(request)
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
        ? MaterialRequestApi(httpClient.instance!,
                errorLogger: httpClient.logger)
            .createRequisitionOrder(request)
            .onError(
            (error, stackTrace) {
              debugPrint(
                  "request ${request.toString()} response ${stackTrace.toString()}");
              return Future.error(Error<CreateMaterialRequisitionResponse>(
                  message: error.toString()));
            },
          ).then((value) => Success(value))
        : Error(message: _noConnectivity);
  }

  Future<RestResponse<ProductsResponse>> productsWithPackingAndUnits() async {
    if (httpClient.instance == null) {
      return Error<ProductsResponse>(
          message: "httpClient.instance is not ready");
    }

    return await connectivityService.isConnected()
        ? ProductsApi(httpClient.instance!)
            .withPackingAndUnit()
            .then((value) => Success(value), onError: (data) {
            log("$data", name: "PRODUCTS_ERROR");
            return Error<ProductsResponse>(message: data.toString());
          })
        : Error(message: _noConnectivity);
  }

  Future<RestResponse<LastMaterialOrdersResponse>> lastMaterialOrdersPickups(
      String customerID) async {
    if (httpClient.instance == null) {
      return Error<LastMaterialOrdersResponse>(
          message: "httpClient.instance is not ready");
    }
    return await connectivityService.isConnected()
        ? MaterialRequestApi(httpClient.instance!)
            .lastMaterialOrdersPickups(customerID)
            .then((value) => Success(value),
                onError: (data) =>
                    Error<LastMaterialOrdersResponse>(message: data.toString()))
        : Error(message: _noConnectivity);
  }

  Future<RestResponse<PreOrdersResponse>> fetchPreOrders(
      String customerID) async {
    if (httpClient.instance == null) {
      return Error<PreOrdersResponse>(
          message: "httpClient.instance is not ready");
    }
    return await connectivityService.isConnected()
        ? PreOrderListApi(httpClient.instance!).preOrderLists().then(
            (value) => Success(value),
            onError: (data) =>
                Error<PreOrdersResponse>(message: data.toString()))
        : Error(message: _noConnectivity);
  }

  Future<RestResponse<CustomersForPreorder>> customersPreorder() async {
    if (httpClient.instance == null) {
      return Error<CustomersForPreorder>(
          message: "httpClient.instance is not ready");
    }
    return await connectivityService.isConnected()
        ? CustomerApi(httpClient.instance!)
            .customersInsPreorder("1", "1")
            .then((value) => Success(value), onError: (data) {
            log("customers in preorder $data");
            return Error<CustomersForPreorder>(message: data.toString());
          })
        : Error(message: _noConnectivity);
  }

  Future<RestResponse<DivisionListResponse>> divisionListApi(
      String query) async {
    if (httpClient.instance == null) {
      return Error<DivisionListResponse>(
          message: "httpClient.instance is not ready");
    }
    return await connectivityService.isConnected()
        ? DivisionListApi(httpClient.instance!).divisionList(query).then(
            (value) {
            log("DIVISION LIST RESPONSE ${value.toString()}");
            return Success(value);
          }, onError: (data) {
            log("DIVISION LIST ERROR $data");
            return Error<DivisionListResponse>(message: data.toString());
          })
        : Error(message: _noConnectivity);
  }
}
