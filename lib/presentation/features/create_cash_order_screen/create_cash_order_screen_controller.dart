import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateCashOrderScreenController extends GetxController {
  var userName = 'Marcel'.obs;

  var shopName = 'Shop 01'.obs;

  var items = '0'.obs;

  var vat = "OMR 0.000".obs;

  var total = "OMR 0.000".obs;

  TextEditingController? customerName = TextEditingController();

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
}
