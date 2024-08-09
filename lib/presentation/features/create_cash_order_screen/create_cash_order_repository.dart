import 'package:suhol_van_sales/domain/models/product.dart';

import '../../../domain/data_source/remote/material_request/request/material_requisition_request.dart';
import '../../../domain/data_source/remote/material_request/response/create_material_requisition.dart';
import '../../../domain/models/customer.dart';

abstract class CreateCashOrderRepository {

  Future<List<Customer>?> findCustomerByName(String query);

  Future<List<Product>?> findProductByName(String query);

  Future<List<Customer>?> findCustomerByEmail(String query);

  Future<CreateMaterialRequisitionResponse?> createRequisition(
      MaterialRequisitionRequest request);

  Future<CreateMaterialRequisitionResponse?> createRequisitionOrder(
      MaterialRequisitionRequest request);
}