import 'package:suhol_van_sales/domain/data_source/remote/material_request/request/material_requisition_request.dart';
import 'package:suhol_van_sales/domain/data_source/remote/material_request/response/create_material_requisition.dart';
import 'package:suhol_van_sales/domain/models/customer.dart';

import '../../../domain/models/product.dart';

abstract class CreateCreditOrderRepository {
  Future<List<Customer>?> findCustomerByName(String query);

  Future<List<Customer>?> findCustomerByLocation(String query);

  Future<List<Product>?> findProductByName(String query);

  Future<CreateMaterialRequisitionResponse?> createRequisition(
      MaterialRequisitionRequest request);

  Future<CreateMaterialRequisitionResponse?> createRequisitionOrder(
      MaterialRequisitionRequest request);
}
