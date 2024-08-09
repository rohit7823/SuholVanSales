import 'package:suhol_van_sales/domain/data_source/local/customers/database/dao/customer_dao.dart';
import 'package:suhol_van_sales/domain/data_source/local/products/dao/product_dao.dart';
import 'package:suhol_van_sales/domain/data_source/remote/material_request/request/material_requisition_request.dart';
import 'package:suhol_van_sales/domain/data_source/remote/material_request/response/create_material_requisition.dart';
import 'package:suhol_van_sales/domain/data_source/remote/web_service_pool.dart';
import 'package:suhol_van_sales/domain/models/customer.dart';
import 'package:suhol_van_sales/domain/models/product.dart';
import 'package:suhol_van_sales/domain/utils/response.dart';
import 'package:suhol_van_sales/presentation/features/create_credit_order_screen/create_credit_order_repository.dart';

class CreateCreditOrderRepositoryImpl extends CreateCreditOrderRepository
    with CustomerDao, ProductDao, WebServicePool {
  @override
  Future<List<Customer>?> findCustomerByLocation(String query) async {
    var hasData = dataCount != null && dataCount! > 0;

    if (hasData) {
      return findByLocation(query);
    } else {
      var result = await customersWithLocations().then((value) {
        if (value is Success) {
          return value.data?.customers;
        } else if (value is Error) {
          return value.message;
        }
      }, onError: (error) => null);

      if (result is List<Customer>? && result != null) {
        insertAll(result);
        return result;
      }

      return null;
    }
  }

  @override
  Future<List<Customer>?> findCustomerByName(String query) async {
    var hasData = dataCount != null && dataCount! > 0;

    if (hasData) {
      return findByName(query);
    } else {
      var result = await customersWithLocations().then((value) {
        if (value is Success) {
          return value.data?.customers;
        } else if (value is Error) {
          return value.message;
        }
      }, onError: (error) => null);

      if (result is List<Customer>? && result != null) {
        insertAll(result);
        return result;
      }

      return null;
    }
  }

  @override
  Future<List<Product>?> findProductByName(String query) async {
    // TODO: implement findProductByName
    return productByName(query);
  }

  @override
  Future<CreateMaterialRequisitionResponse?> createRequisition(
      MaterialRequisitionRequest request) async {

    var result =  await createMaterialRequisition(request);
    if (result is Success) {
      return result.data;
    } else if (result is Error) {
      return null;
    }
    return null;
  }

  @override
  Future<CreateMaterialRequisitionResponse?> createRequisitionOrder(
      MaterialRequisitionRequest request) async {
    var result =  await createMaterialRequisitionOrder(request);
    if (result is Success) {
      return result.data;
    } else if (result is Error) {
      return null;
    }
    return null;
  }
}
