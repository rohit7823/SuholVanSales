import 'package:flutter/cupertino.dart';
import 'package:suhol_van_sales/domain/data_source/local/products/dao/product_dao.dart';
import 'package:suhol_van_sales/domain/data_source/remote/material_request/request/material_requisition_request.dart';
import 'package:suhol_van_sales/domain/data_source/remote/material_request/response/create_material_requisition.dart';
import 'package:suhol_van_sales/domain/data_source/remote/web_service_pool.dart';
import 'package:suhol_van_sales/domain/models/customer.dart';
import 'package:suhol_van_sales/domain/models/product.dart';
import 'package:suhol_van_sales/domain/utils/response.dart';
import 'package:suhol_van_sales/presentation/features/create_credit_order_screen/create_credit_order_repository.dart';

class CreateCreditOrderRepositoryImpl extends CreateCreditOrderRepository
    with ProductDao, WebServicePool {
  @override
  Future<List<Customer>?> findCustomerByLocation(String query) async {
    var hasData = isInMemoryCustomersAvailable;

    if (hasData) {
      return customersCache
          .where((element) =>
              element.location?.toLowerCase().contains(query.toLowerCase()) ??
              false)
          .toList();
    } else {
      var result = await customersWithLocations().then((value) {
        if (value is Success) {
          return value.data?.customers;
        } else if (value is Error) {
          return value.message;
        }
      }, onError: (error) => null);
      if (result is List<Customer>? && result != null) {
        customersCache.addAll(result);
        return result;
      }

      return null;
    }
  }

  @override
  Future<List<Customer>?> findCustomerByName(String query) async {
    var hasData = isInMemoryCustomersAvailable;

    if (hasData) {
      return customersCache
          .where((element) =>
              element.name?.toLowerCase().contains(query.toLowerCase()) ??
              false)
          .toList();
    } else {
      var result = await customersWithLocations().then((value) {
        if (value is Success) {
          return value.data?.customers;
        } else if (value is Error) {
          return value.message;
        }
      }, onError: (error) => null);

      if (result is List<Customer>? && result != null) {
        customersCache.addAll(result);
        return result;
      }

      return null;
    }
  }

  @override
  Future<List<Product>?> findProductByName(String query) async {
    if (isInMemoryProductsAvailable) {
      return productsCache
          .where(
            (element) =>
                element.name?.toLowerCase().contains(query.toLowerCase()) ??
                false,
          )
          .toList();
    } else {
      var values = await productsWithPackingAndUnits().then((value) {
        if (value is Success) {
          return value.data?.data;
        } else if (value is Error) {
          return value.message;
        }
      }, onError: (error) => null);
      if (values is List<Product>? && values != null) {
        productsCache.addAll(values);
      }
      return null;
    }
  }

  @override
  Future<RestResponse<CreateMaterialRequisitionResponse>> createRequisition(
      MaterialRequisitionRequest request) async {
    debugPrint("request ${request.toJson()}");
    var result = await createMaterialRequisition(request);
    debugPrint("result ${result.data?.toJson()}");
    return result;
  }

  @override
  Future<RestResponse<CreateMaterialRequisitionResponse>>
      createRequisitionOrder(MaterialRequisitionRequest request) async {
    var result = await createMaterialRequisitionOrder(request);

    return result;
  }
}
