import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/domain/data_source/remote/material_request/request/material_requisition_request.dart';
import 'package:suhol_van_sales/domain/di/session_service.dart';
import 'package:suhol_van_sales/presentation/features/create_credit_order_screen/create_credit_order_repository.dart';

import '../../../domain/models/customer.dart';
import '../../../domain/models/product.dart';

class CreateCreditOrderScreenController extends GetxController {
  final _repo = Get.find<CreateCreditOrderRepository>();
  final _session = Get.find<SessionService>();

  var userName = ''.obs;

  var shopName = ''.obs;

  SearchController? customerName = SearchController();

  SearchController? customerLocation = SearchController();

  TextEditingController? vehicleNumber = TextEditingController();

  TextEditingController? mobileNumber = TextEditingController();

  SearchController? productName = SearchController();

  SearchController? packing = SearchController();

  SearchController? unit = SearchController();

  TextEditingController? qty = TextEditingController();

  TextEditingController? price = TextEditingController();

  TextEditingController? remarks = TextEditingController();

  Packing? selectedPacking;

  UnitElement? selectedUnit;

  Rx<Product?> selectedProduct = Rx(null);

  var items = '0'.obs;

  var vat = "OMR 0.000".obs;

  var total = "OMR 0.000".obs;

  Customer? _selectedCustomer;

  @override
  void onReady() {
    super.onReady();

    qty?.addListener(_onQtyChange);
    price?.addListener(_calculatePrice);

    userName.value = _session.userDetails?.name ?? "Welcome";
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

  var orderLoading = false.obs;
  var addItemLoading = false.obs;

  Future<void> onSubmitOrder() async {
    orderLoading.value = true;
    var request = MaterialRequisitionRequest(
        customerId: _selectedCustomer?.id,
        productId: selectedProduct.value?.id,
        packingId: selectedPacking?.id,
        vehicleNo: vehicleNumber?.text,
        deliveryDate: DateTime.now(),
        remarks: remarks?.text,
        unitOfMeasurementId: selectedUnit?.id);
    var result = await _repo.createRequisition(request);
    orderLoading.value = false;
    if (result != null) {
      switch (result.success) {
        case true:
          await Future.delayed(const Duration(milliseconds: 500)).then(
                (value) {
              Get.back();
            },
          );
          Get.showSnackbar(GetSnackBar(
            message: "${result.message}",
            duration: const Duration(seconds: 5),
          ));

          break;
        case false:
          Get.showSnackbar(GetSnackBar(
            message: "${result.message ?? result.error}",
            duration: const Duration(seconds: 5),
          ));
        case null:
          Get.showSnackbar(GetSnackBar(
            message: "${result.error}",
            duration: const Duration(seconds: 5),
          ));
          break;
      }
    }
  }

  Future<void> onAddItem() async {
    addItemLoading.value = true;
    var request = MaterialRequisitionRequest(
        customerId: _selectedCustomer?.id,
        productId: selectedProduct.value?.id,
        packingId: selectedPacking?.id,
        vehicleNo: vehicleNumber?.text,
        deliveryDate: DateTime.now(),
        remarks: remarks?.text,
        unitOfMeasurementId: selectedUnit?.id);
    var result = await _repo.createRequisitionOrder(request);
    addItemLoading.value = false;
    if (result != null) {
      switch (result.success) {
        case true:
          await Future.delayed(const Duration(milliseconds: 500)).then(
                (value) {
              Get.back();
            },
          );
          Get.showSnackbar(GetSnackBar(
            message: "${result.message}",
            duration: const Duration(seconds: 5),
          ));

          break;
        case false:
          Get.showSnackbar(GetSnackBar(
            message: "${result.message ?? result.error}",
            duration: const Duration(seconds: 5),
          ));
        case null:
          Get.showSnackbar(GetSnackBar(
            message: "${result.error}",
            duration: const Duration(seconds: 5),
          ));
          break;
      }
    }
  }

  FutureOr<Iterable<Customer>> findCustomerName(
      SearchController searchController) async {
    debugPrint("query ${searchController.text}");
    var values = await _repo.findCustomerByName(searchController.text);
    return values ?? [];
  }

  void onSelectCustomer(Customer result, SearchController controller) {
    if (result.name == null) return;
    controller.text = result.name!;
    _selectedCustomer = result;
  }

  FutureOr<Iterable<Customer>> findCustomerLocation(
      SearchController searchController) async {
    var values = await _repo.findCustomerByLocation(searchController.text);
    return values ?? [];
  }

  FutureOr<Iterable<Packing>> findProductPacking(
      SearchController searchController) {
    debugPrint("query ${searchController.text}");
    var values = selectedProduct.value?.packings
        ?.where(
          (element) =>
              element.packing
                  ?.isCaseInsensitiveContains(searchController.text) ??
              false,
        )
        .toList();
    return values ?? [];
  }

  FutureOr<Iterable<Product>> findProductName(
      SearchController searchController) async {
    debugPrint("query ${searchController.text}");
    var values = await _repo.findProductByName(searchController.text);
    return values ?? [];
  }

  FutureOr<Iterable<UnitElement>> findProductUnit(
      SearchController searchController) {
    debugPrint("query ${searchController.text}");
    var values = selectedProduct.value?.units
        ?.where(
          (element) =>
              element.name?.name
                  .isCaseInsensitiveContains(searchController.text) ??
              false,
        )
        .toList();
    return values ?? [];
  }

  void onSelectCustomerLocation(Customer result, SearchController controller) {
    if (result.location == null) return;
    controller.text = result.location!;
  }

  void onSelectProductPacking(Packing result, SearchController controller) {
    if (result.packing == null) return;
    controller.text = result.packing ?? "None";
    selectedPacking = result;
  }

  void onSelectProductUnit(UnitElement result, SearchController controller) {
    if (result.name?.name == null) return;
    controller.text = result.name?.name ?? "None";
    selectedUnit = result;
  }

  void onSelectProduct(Product result, SearchController controller) {
    if (result.name == null) return;
    controller.text = result.name ?? result.alias ?? "";
    selectedProduct.value = result;
    clearSelectedPacking();
    clearSelectedUnit();
  }

  void clearSelectedPacking() {
    packing?.text = "";
    selectedPacking = null;
  }

  void clearSelectedUnit() {
    unit?.text = "";
    selectedUnit = null;
  }
}
