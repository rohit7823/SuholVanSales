import 'package:suhol_van_sales/domain/data_source/local/customers/database/dao/customer_dao.dart';
import 'package:suhol_van_sales/domain/data_source/local/customers/static_customers.dart';

class DataBinding with CustomerDao {

  Future<void> init() async {
    if(dataCount == null || dataCount! == 0) {
      var data = await StaticCustomers.getData();
      var customers = data?.customers;
      if (customers != null) {
        var status = await insertAll(customers);
      }
    }
  }
}
