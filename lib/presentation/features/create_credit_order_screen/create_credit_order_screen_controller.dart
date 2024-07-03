import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/domain/data_source/local/customers/database/dao/customer_dao.dart';

import '../../../domain/models/customer_details.dart';

class CreateCreditOrderScreenController extends GetxController with CustomerDao{

  var userName = 'Marcel'.obs;

  var shopName = 'Shop 01'.obs;

  SearchController? customerName = SearchController();

  SearchController? customerLocation = SearchController();

  TextEditingController? vehicleNumber = TextEditingController();

  TextEditingController? mobileNumber = TextEditingController();

  TextEditingController? productName = TextEditingController();

  TextEditingController? packing = TextEditingController();

  TextEditingController? unit = TextEditingController();

  TextEditingController? qty = TextEditingController();

  TextEditingController? price = TextEditingController();

  TextEditingController? remarks = TextEditingController();

  var items = '0'.obs;

  var vat = "OMR 0.000".obs;

  var total = "OMR 0.000".obs;

  Customer? _selectedCustomer;

  @override
  void onReady() {
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
    qty?.removeListener(_onQtyChange);
    price?.removeListener(_calculatePrice);
    customerName?.dispose();
    customerLocation?.dispose();
    vehicleNumber?.dispose();
    mobileNumber?.dispose();
    productName?.dispose();
    unit?.dispose();
    qty?.dispose();
    price?.dispose();
    remarks?.dispose();
    customerName = null;
    customerLocation = null;
    vehicleNumber = null;
    mobileNumber = null;
    productName = null;
    unit = null;
    qty = null;
    price = null;
    remarks = null;
  }

  void pop() {
    Get.back();
  }

  void onClickSendCustomerName() {
    customerName?.openView();
  }

  void onClickSendCustomerLocation() {
    customerLocation?.openView();
  }

  void onSubmitOrder() {}

  void onAddItem() {}

  FutureOr<Iterable<Customer>> findCustomerName(SearchController searchController) async {
    debugPrint("query ${searchController.text}");
    var values = await findByName(searchController.text);
    return values ?? [];

  }

  void onSelectCustomer(Customer result, SearchController controller) {
    if(result.name == null) return;
    controller.text = result.name!;
    _selectedCustomer = result;
  }

  FutureOr<Iterable<Customer>> findCustomerLocation(SearchController searchController) async {
    var values = await findByLocation(searchController.text);
    return values ?? [];
  }

  void onSelectCustomerLocation(Customer result, SearchController controller) {
    if(result.location == null) return;
    controller.text = result.location!;
  }
}
