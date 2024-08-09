import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/domain/data_source/local/customers/database/dao/customer_dao.dart';
import 'package:suhol_van_sales/domain/di/session_service.dart';
import 'package:suhol_van_sales/domain/models/customer.dart';
import 'package:suhol_van_sales/domain/models/product.dart';
import 'package:suhol_van_sales/presentation/features/create_cash_order_screen/create_cash_order_repository.dart';

import '../../../domain/data_source/remote/material_request/request/material_requisition_request.dart';

class CreateCashOrderScreenController extends GetxController {
  final _repo = Get.find<CreateCashOrderRepository>();
  final _session = Get.find<SessionService>();

  var userName = ''.obs;

  var shopName = ''.obs;

  var items = '0'.obs;

  var vat = "OMR 0.000".obs;

  var total = "OMR 0.000".obs;

  Customer? _selectedCustomer;

  Rx<Product?> selectedProduct = Rx(null);

  SearchController? customerName = SearchController();

  SearchController? email = SearchController();

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

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    qty?.addListener(_onQtyChange);
    price?.addListener(_calculatePrice);

    userName.value = _session.userDetails?.name ?? 'Welcome';
  }

  void _calculatePrice() {
    var q = double.tryParse(qty?.text ?? '0.00');
    var p = double.tryParse(price?.text ?? '0.00');
    if (q == null && p == null) return;
    if (q != null && p != null) {
      total.value = (q * p).toStringAsPrecision(3);
    }
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

  void onClickSendEmail() {
    email?.openView();
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
        unitOfMeasurementId: selectedUnit?.id
    );
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

  FutureOr<Iterable<Product>> findProductName(
      SearchController searchController) async {
    debugPrint("query ${searchController.text}");
    var values = await _repo.findProductByName(searchController.text);
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

  void onSelectCustomer(Customer result, SearchController controller) {
    if (result.name == null) return;
    controller.text = result.name!;
    _selectedCustomer = result;
  }

  void onSelectProduct(Product result, SearchController controller) {
    if (result.name == null) return;
    controller.text = result.name ?? result.alias ?? "";
    selectedProduct.value = result;
    clearSelectedPacking();
    clearSelectedUnit();
  }

  FutureOr<Iterable<Customer>> findCustomerEmail(
      SearchController searchController) async {
    var values = await _repo.findCustomerByEmail(searchController.text);
    return values ?? [];
  }

  void onSelectCustomerEmail(Customer result, SearchController controller) {
    if (result.email == null) return;
    controller.text = result.email!;
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

  void clearSelectedPacking() {
    packing?.text = "";
    selectedPacking = null;
  }

  void clearSelectedUnit() {
    unit?.text = "";
    selectedUnit = null;
  }
}
