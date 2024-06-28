import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/domain/data_source/local/customers/database/entities/customer_db.dart';
import 'package:suhol_van_sales/domain/di/database_service.dart';
import 'package:suhol_van_sales/domain/models/customer_details.dart';
import 'package:suhol_van_sales/domain/utils/extenstions.dart';
import 'package:suhol_van_sales/objectbox.g.dart';

mixin CustomerDao {
  final _customerDB = Get.find<DatabaseService>().db?.box<CustomerDB>();

  int? get dataCount => _customerDB?.count();

  Future<List<CustomerDB>?> findByLocation(String locationQuery) async {
    return await _customerDB
        ?.query(CustomerDB_.location.contains(locationQuery))
        .build()
        .findAsync();
  }

  Future<List<CustomerDB>?> findByName(String nameQuery) async {
    return await _customerDB
        ?.query(CustomerDB_.name.contains(nameQuery))
        .build()
        .findAsync();
  }

  Future<List<CustomerDB>?> findByEmail(String emailQuery) async {
    return await _customerDB
        ?.query(CustomerDB_.email.contains(emailQuery))
        .build()
        .findAsync();
  }

  int? insert(Customer customer) {
    var cDB = customer.toDB;
    cDB.locations.addAll(customer.locations?.map((e) => e.toDB) ?? []);
    return _customerDB?.putQueued(cDB);
  }

  bool insertAll(List<Customer> customers) {
    var isSuccess = customers
        .map(
          (e) => insert(e),
        )
        .every(
          (id) => id != null,
        );
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
