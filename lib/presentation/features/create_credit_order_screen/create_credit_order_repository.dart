import 'package:suhol_van_sales/domain/models/customer.dart';

abstract class CreateCreditOrderRepository {
  Future<List<Customer>?> findCustomerByName(String query);
  Future<List<Customer>?> findCustomerByLocation(String query);
}