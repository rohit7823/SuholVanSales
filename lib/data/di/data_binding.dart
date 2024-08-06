import 'package:flutter/cupertino.dart';
import 'package:suhol_van_sales/domain/data_source/local/customers/database/dao/customer_dao.dart';
import 'package:suhol_van_sales/domain/data_source/local/customers/static_customers.dart';
import 'package:suhol_van_sales/domain/data_source/local/products/dao/product_dao.dart';
import 'package:suhol_van_sales/domain/data_source/local/products/static_products.dart';

class DataBinding with CustomerDao, ProductDao {

  Future<void> initCustomers() async {
    if(dataCount == null || dataCount! == 0) {
      var data = await StaticCustomers.getData();
      var customers = data?.customers;
      if (customers != null) {
        var status = await insertAll(customers);
      }
    }
  }

  Future<void> initProducts() async {
    if(dataCount == null || dataCount! == 0) {
      var data = await StaticProducts.getData();
      var products = data?.data;
      if (products != null) {
        var status = await insertAllProducts(products);
      }
    }
  }
}
