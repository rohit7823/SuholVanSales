import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:suhol_van_sales/domain/data_source/local/products/dao/product_dao.dart';
import 'package:suhol_van_sales/domain/data_source/remote/customers/response/customers_with_locations_response.dart';
import 'package:suhol_van_sales/domain/data_source/remote/division_management/response/division_list_response.dart';
import 'package:suhol_van_sales/domain/data_source/remote/material_request/request/material_requisition_request.dart';
import 'package:suhol_van_sales/domain/data_source/remote/material_request/response/create_material_requisition.dart';
import 'package:suhol_van_sales/domain/data_source/remote/material_request/response/last_material_orders_response.dart';
import 'package:suhol_van_sales/domain/data_source/remote/pre_order/response/pre_orders_response.dart';
import 'package:suhol_van_sales/domain/data_source/remote/products/response/products_response.dart';
import 'package:suhol_van_sales/domain/data_source/remote/web_service_pool.dart';
import 'package:suhol_van_sales/domain/models/customer.dart';
import 'package:suhol_van_sales/domain/models/product.dart';
import 'package:suhol_van_sales/domain/utils/response.dart';
import 'package:suhol_van_sales/presentation/features/create_credit_order_screen/create_order_repository.dart';

class CreateOrderRepositoryImpl extends CreateOrderRepository
    with ProductDao, WebServicePool {
  static List<Customer> customersCache = [];
  static List<Customer> customersPreorderCache = [];
  static List<Division> divisionsCache = [];
  static List<Product> productsCache = [];

  Future<void> sync() async {
    await Future.wait([
      _syncCustomers(),
      _syncProducts(),
      _syncCustomersPreorder(),
      _syncDivisions()
    ]);
  }

  @override
  Future<void> fetchData() async {
    await Future.wait([
      findCustomerByName(""),
      findProductByName(""),
      findDivisions(""),
      findCustomersForPreorder("")
    ]);
  }

  Future<void> _syncCustomers() async {
    var result = await customersWithLocations().then((value) {
      if (value is Success) {
        return value.data?.customers;
      } else if (value is Error) {
        return value.message;
      }
    }, onError: (error) => null);
    if (result is List<Customer>? && result != null) {
      customersCache.addAll(result);
    }
  }

  Future<void> _syncCustomersPreorder() async {
    var result = await customersPreorder().then((value) {
      if (value is Success) {
        return value.data?.data;
      } else if (value is Error) {
        return value.message;
      }
    }, onError: (error) => null);
    if (result is List<Customer>? && result != null) {
      customersPreorderCache.addAll(result);
      log("VALUES ARE SET FOR PRE-ORDER CUSTOMERS");
    }
  }

  Future<void> _syncDivisions() async {
    var result = await divisionList("").then((value) {
      if (value is Success) {
        return value.data?.data;
      } else if (value is Error) {
        return value.message;
      }
    }, onError: (error) => null);
    if (result is List<Division>? && result != null) {
      divisionsCache.addAll(result);
      log("VALUES ARE SET FOR DIVISION");
    }
  }

  Future<void> _syncProducts() async {
    var values = await productsWithPackingAndUnits().then((value) {
      if (value is Success) {
        return value.data?.data;
      } else if (value is Error) {
        return value.message;
      }
    }, onError: (error) => null);
    if (values is List<Product>? && values != null) {
      productsCache.addAll(values);
      log("VALUES ARE SET");
    }
  }

  @override
  Future<List<Customer>?> findCustomerByLocation(String query) async {
    //var hasData = isInMemoryCustomersAvailable;

    if (customersCache.isNotEmpty) {
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
    //var hasData = isInMemoryCustomersAvailable;

    if (customersCache.isNotEmpty) {
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
  Future<List<Customer>?> findCustomersForPreorder(String query) async {
    if (customersPreorderCache.isNotEmpty) {
      return customersPreorderCache
          .where((element) =>
              element.name?.toLowerCase().contains(query.toLowerCase()) ??
              false)
          .toList();
    } else {
      var result = await customersPreorder().then((value) {
        if (value is Success) {
          return value.data?.data;
        } else if (value is Error) {
          return value.message;
        }
      }, onError: (error) => null);

      if (result is List<Customer>? && result != null) {
        customersPreorderCache.addAll(result);
        return result;
      }

      return null;
    }
  }

  @override
  Future<List<Product>?> findProductByName(String query) async {
    if (productsCache.isNotEmpty) {
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
          log("PRODUCTS ERROR ${value.message}");
          return value.message;
        }
      }, onError: (error) => null);
      if (values is List<Product>? && values != null) {
        productsCache.addAll(values);
        log("VALUES ARE SET");
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
    debugPrint(
        "RESP --- ${request.toJson()} \n\nRESULT -- ${result.data?.toJson()}");
    return result;
  }

  @override
  Future<RestResponse<LastMaterialOrdersResponse>> lastPickupOrders(
          String customerID) async =>
      await lastMaterialOrdersPickups(customerID);

  static void _fetchCustomers(List<dynamic> args) async {
    Future<RestResponse<CustomersWithLocationResponse>> Function() apiClosure =
        args[0];
    List<Customer> cache = args[1];
    var result = await apiClosure().then((value) {
      if (value is Success) {
        return value.data?.customers;
      } else if (value is Error) {
        return value.message;
      }
    }, onError: (error) => null);
    if (result is List<Customer>? && result != null) {
      cache.addAll(result);
    }
  }

  static void _fetchProducts(List<dynamic> args) async {
    Future<RestResponse<ProductsResponse>> Function() apiClosure = args[0];
    List<Product> cache = args[1];

    var values = await apiClosure().then((value) {
      if (value is Success) {
        return value.data?.data;
      } else if (value is Error) {
        return value.message;
      }
    }, onError: (error) => null);
    if (values is List<Product>? && values != null) {
      cache.addAll(values);
    }
  }

  @override
  Future<RestResponse<PreOrdersResponse>> preOrders(String customerID) =>
      fetchPreOrders(customerID);

  @override
  Future<RestResponse<DivisionListResponse>> divisionList(String query) async =>
      await divisionListApi(query);

  @override
  Future<List<Division>?> findDivisions(String query) async {
    if (divisionsCache.isNotEmpty) {
      return divisionsCache
          .where(
            (element) =>
                element.divisionName
                    ?.toLowerCase()
                    .contains(query.toLowerCase()) ??
                false,
          )
          .toList();
    } else {
      var values = await divisionList(query).then((value) {
        if (value is Success) {
          return value.data?.data;
        } else if (value is Error) {
          debugPrint("DIVISIONS ERROR ${value.message}");
          return value.message;
        }
      }, onError: (error) => null);
      if (values is List<Division>? && values != null) {
        divisionsCache.addAll(values);
        log("VALUES ARE SET");
      }
      return null;
    }
  }
}
