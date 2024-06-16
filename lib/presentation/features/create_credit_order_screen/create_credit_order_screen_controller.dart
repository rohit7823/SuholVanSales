import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateCreditOrderScreenController extends GetxController {
  var userName = 'Marcel'.obs;

  var shopName = 'Shop 01'.obs;

  TextEditingController? customerName = TextEditingController();

  TextEditingController? customerLocation = TextEditingController();

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

  void onClickSendCustomerName() {}

  void onClickSendCustomerLocation() {}

  void onSubmitOrder() {}

  void onAddItem() {}
}
