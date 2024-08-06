import 'package:suhol_van_sales/domain/models/customer.dart';

import '../../../domain/models/product.dart';

abstract class CreateCreditOrderRepository {
  Future<List<Customer>?> findCustomerByName(String query);
  Future<List<Customer>?> findCustomerByLocation(String query);
  Future<List<Product>?> findProductByName(String query);
}