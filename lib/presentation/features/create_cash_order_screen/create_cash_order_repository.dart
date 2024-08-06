import 'package:suhol_van_sales/domain/models/product.dart';

import '../../../domain/models/customer.dart';

abstract class CreateCashOrderRepository {

  Future<List<Customer>?> findCustomerByName(String query);

  Future<List<Product>?> findProductByName(String query);

  Future<List<Customer>?> findCustomerByEmail(String query);
}