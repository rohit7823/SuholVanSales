import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/data/utils/extensions.dart';
import 'package:suhol_van_sales/domain/data_source/local/customers/database/entities/customer_db.dart';
import 'package:suhol_van_sales/domain/di/database_service.dart';
import 'package:suhol_van_sales/domain/models/customer.dart';
import 'package:suhol_van_sales/domain/utils/extenstions.dart';
import 'package:suhol_van_sales/objectbox.g.dart';

mixin CustomerDao {
  final Map<int, List<Customer>> _customersCache = {};

  final byLocation = 1;
  final byName = 2;
  final byEmail = 3;

  final _dbInstance = Get.find<DatabaseService>().db;

  Box<CustomerDB>? get _customerDB => _dbInstance?.box<CustomerDB>();

  int? get dataCount => _customerDB?.count();

  Future<List<Customer>?> findByLocation(String locationQuery) async {
    if (_customersCache.containsKey(byLocation) &&
        (_customersCache[byLocation]?.isNotEmpty == true)) {
      return _customersCache[byLocation]
          ?.where(
            (element) => element.location?.isCaseInsensitiveContains(
              locationQuery,
            ) ?? false,
          )
          .toList();
    } else {
      var data = await _customerDB
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
      _customersCache.addIf(data != null, byLocation, data!);

      return data;
    }
  }

  Future<List<Customer>?> findByName(String nameQuery) async {
    if (_customersCache.containsKey(byName) &&
        (_customersCache[byName]?.isNotEmpty == true)) {
      return _customersCache[byName]
          ?.where(
            (element) => element.name?.isCaseInsensitiveContains(
              nameQuery,
            ) ?? false,
          )
          .toList();
    } else {
      var data = await _customerDB
          ?.query(
              CustomerDB_.location.contains(nameQuery, caseSensitive: false))
          .build()
          .findAsync()
          .then(
            (value) => value.map(
              (e) => e.toData
            ).toList()
          );
      _customersCache.addIf(data != null, byName, data!);
      return data;
    }
  }

  Future<List<Customer>?> findByEmail(String emailQuery) async {
    if (_customersCache.containsKey(byEmail) &&
        (_customersCache[byEmail]?.isNotEmpty == true)) {
      return _customersCache[byEmail]
          ?.where(
            (element) => element.name?.isCaseInsensitiveContains(
              emailQuery,
        ) ?? false,
      )
          .toList();
    } else {
      var data =  await _customerDB
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
      _customersCache.addIf(data != null, byEmail, data!);
      return data;
    }
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
