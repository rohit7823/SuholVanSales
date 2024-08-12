import 'dart:async';

import 'package:get/get.dart';
import 'package:suhol_van_sales/data/utils/extensions.dart';
import 'package:suhol_van_sales/domain/data_source/local/customers/database/entities/customer_db.dart';
import 'package:suhol_van_sales/domain/di/database_service.dart';
import 'package:suhol_van_sales/domain/models/customer.dart';
import 'package:suhol_van_sales/domain/utils/extenstions.dart';
import 'package:suhol_van_sales/objectbox.g.dart';

mixin CustomerDao {
  final _dbInstance = Get.find<DatabaseService>().db;

  Box<CustomerDB>? get _customerDB => _dbInstance?.box<CustomerDB>();

  int? get hasCustomers => _customerDB?.count();

  Future<List<Customer>?> findByLocation(String locationQuery) async {
    return await _customerDB
        ?.query(
            CustomerDB_.location.contains(locationQuery, caseSensitive: false))
        .build()
        .findAsync()
        .then(
          (value) => value
              .map(
                (e) => e.toData,
              )
              .toList(),
        );
  }

  Future<List<Customer>?> findByName(String nameQuery) async {
    var data = await _customerDB
        ?.query(CustomerDB_.name.contains(nameQuery, caseSensitive: false))
        .build()
        .findAsync()
        .then((value) => value.map((e) => e.toData).toList());
    //_customersCache.addIf(data != null, byName, data!);
    return data;
  }

  Future<List<Customer>?> findByEmail(String emailQuery) async {
    return await _customerDB
        ?.query(CustomerDB_.email.contains(emailQuery, caseSensitive: false))
        .build()
        .findAsync()
        .then(
          (value) => value
              .map(
                (e) => e.toData,
              )
              .toList(),
        );
  }

  Future<int?> insert(Customer customer) async {
    var cDB = customer.toDB;
    cDB.locations.addAll(customer.locations?.map((e) => e.toDB) ?? []);
    return await _customerDB?.putAsync(cDB);
  }

  Future<bool?> insertAll(List<Customer> customers) async {
    var isSuccess = await _dbInstance?.runInTransactionAsync(TxMode.write,
        (store, customers) {
      var tmp = customers
          .map(
            (e) => e.toDB,
          )
          .toList();
      var db = store.box<CustomerDB>();
      var ids = db.putMany(tmp);
      return ids.every((id) => id != 0);
    }, customers);

    return isSuccess;
  }

  Future<bool?> remove(String customerCode) async {
    var entity = await _customerDB
        ?.query(CustomerDB_.customerCode.equals(customerCode))
        .build()
        .findUniqueAsync();

    entity?.locations.clear();

    if (entity?.dbId == null) return false;
    return await _customerDB?.removeAsync(entity!.dbId!);
  }
}
