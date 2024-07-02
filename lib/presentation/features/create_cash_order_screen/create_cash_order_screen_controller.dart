import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/domain/data_source/local/customers/database/dao/customer_dao.dart';
import 'package:suhol_van_sales/domain/models/customer_details.dart';

class CreateCashOrderScreenController extends GetxController with CustomerDao {

  var userName = 'Marcel'.obs;

  var shopName = 'Shop 01'.obs;

  var items = '0'.obs;

  var vat = "OMR 0.000".obs;

  var total = "OMR 0.000".obs;

  SearchController? customerName = SearchController();

  TextEditingController? email = TextEditingController();

  TextEditingController? vehicleNumber = TextEditingController();

  TextEditingController? mobileNumber = TextEditingController();

  TextEditingController? productName = TextEditingController();

  TextEditingController? packing = TextEditingController();

  TextEditingController? unit = TextEditingController();

  TextEditingController? qty = TextEditingController();

  TextEditingController? price = TextEditingController();

  TextEditingController? remarks = TextEditingController();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    qty?.addListener(_onQtyChange);
    price?.addListener(_calculatePrice);
  }

  void _calculatePrice() {
    var q = double.tryParse(qty?.text ?? '0.00');
    var p = double.tryParse(price?.text ?? '0.00');
    if (q == null && p == null) return;
    total.value = (q! * p!).toStringAsPrecision(3);
  }

  void _onQtyChange() {
    items.value = qty?.text ?? items.value;
    _calculatePrice();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    vehicleNumber?.dispose();
    mobileNumber?.dispose();
    productName?.dispose();
    unit?.dispose();
    qty?.dispose();
    price?.dispose();
    remarks?.dispose();
    email?.dispose();
    customerName = null;
    vehicleNumber = null;
    mobileNumber = null;
    productName = null;
    unit = null;
    qty = null;
    price = null;
    remarks = null;
    email = null;
  }

  void pop() {
    Get.back();
  }

  void onClickSendEmail() {}

  void onSubmitOrder() {}

  void onAddItem() {}

  FutureOr<Iterable<Customer>> findCustomerName(SearchController searchController) async {
    debugPrint("query ${searchController.text}");

    var values = await findByName(searchController.text);
    return values ?? [];

  }

  void onSelectCustomer(Customer result, SearchController controller) {


  }
}
