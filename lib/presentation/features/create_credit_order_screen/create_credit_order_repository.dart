import 'package:suhol_van_sales/domain/data_source/remote/material_request/request/material_requisition_request.dart';
import 'package:suhol_van_sales/domain/data_source/remote/material_request/response/create_material_requisition.dart';
import 'package:suhol_van_sales/domain/data_source/remote/material_request/response/last_material_orders_response.dart';
import 'package:suhol_van_sales/domain/models/customer.dart';
import 'package:suhol_van_sales/domain/utils/response.dart';

import '../../../domain/models/product.dart';

abstract class CreateCreditOrderRepository {
  final List<Customer> customersCache = [];
  final List<Product> productsCache = [];

  bool get isInMemoryCustomersAvailable => customersCache.isNotEmpty;
  bool get isInMemoryProductsAvailable => productsCache.isNotEmpty;

  Future<List<Customer>?> findCustomerByName(String query);

  Future<List<Customer>?> findCustomerByLocation(String query);

  Future<List<Product>?> findProductByName(String query);

  Future<RestResponse<CreateMaterialRequisitionResponse>> createRequisition(
      MaterialRequisitionRequest request);

  Future<RestResponse<CreateMaterialRequisitionResponse>>
      createRequisitionOrder(MaterialRequisitionRequest request);

  Future<RestResponse<LastMaterialOrdersResponse>> lastPickupOrders(String customerID);
}
