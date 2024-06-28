import 'package:flutter/cupertino.dart';
import 'package:suhol_van_sales/domain/data_source/local/customers/database/dao/customer_dao.dart';
import 'package:suhol_van_sales/domain/data_source/local/customers/static_customers.dart';

class CustomersBinding with CustomerDao {

  Future<void> init() async {
    debugPrint("dataCount $dataCount");
    if(dataCount == null || dataCount! == 0) {
      var data = await StaticCustomers.getData();
      var customers = data?.customers;
      if (customers != null) {
        var status = insertAll(customers);
        debugPrint("status $status");
      }
    }
  }
}
