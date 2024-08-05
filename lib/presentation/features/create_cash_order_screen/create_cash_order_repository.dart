import '../../../domain/models/customer.dart';

abstract class CreateCashOrderRepository {

  Future<List<Customer>?> findCustomerByName(String query);

  Future<List<Customer>?> findCustomerByEmail(String query);
}