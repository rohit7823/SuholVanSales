import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:suhol_van_sales/data/repo_impls/create_credit_order_repository_impl.dart';
import 'package:suhol_van_sales/domain/di/session_service.dart';
import 'package:suhol_van_sales/domain/models/customer.dart';
import 'package:suhol_van_sales/domain/models/product.dart';
import 'package:suhol_van_sales/presentation/models/location_with_quantity_ui_model.dart';
import 'package:suhol_van_sales/presentation/widgets/animated_progress.dart';

import '../../models/added_product_ui_model.dart';

class CreateMrOrderScreenController extends GetxController {
  final _session = Get.find<SessionService>();
  final _repo = Get.find<CreateCreditOrderRepositoryImpl>();
  var userName = ''.obs;
  var shopName = ''.obs;

  SearchController? divisionName = SearchController();

  var userLocationDropdownController =
      MultiSelectController<LocationWithQuantityUiModel>();

  SearchController? packing = SearchController();

  SearchController? unit = SearchController();

  Packing? selectedPacking;

  Rx<Product?> selectedProduct = Rx(null);

  UnitElement? selectedUnit;

  TextEditingController? qty = TextEditingController();

  TextEditingController? price = TextEditingController();

  TextEditingController? remarks = TextEditingController();

  RxList<AddedProductUiModel> addedProducts = RxList.empty();

  SearchController? productName = SearchController();

  Customer? _selecteddivisionName;

  var orderLoading = false.obs;
  var addItemLoading = false.obs;

  void pop() {
    Get.back();
  }

  FutureOr<Iterable<Product>> findProductName(
      SearchController searchController) async {
    if (searchController.text.isBlank == true) {
      return [];
    }

    AnimatedProgress.showProgressIfNot();
    var values = await _repo.findProductByName(searchController.text);
    AnimatedProgress.closeProgressIfShowing();
    return values ?? [];
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

  void onSelectProductPacking(Packing result, SearchController controller) {
    if (result.packing == null) return;
    controller.text = result.packing ?? "None";
    selectedPacking = result;
  }

  FutureOr<Iterable<UnitElement>> findProductUnit(
      SearchController searchController) {
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

  void onSelectProductUnit(UnitElement result, SearchController controller) {
    if (result.name?.name == null) return;
    controller.text = result.name?.name ?? "None";
    selectedUnit = result;
  }

  FutureOr<Iterable<Customer>> finddivisionName(
      SearchController searchController) async {
    if (searchController.text.isBlank == true) {
      return [];
    }

    AnimatedProgress.showProgressIfNot();
    var values = await _repo.findCustomerByName(searchController.text);
    AnimatedProgress.closeProgressIfShowing();

    return values ?? [];
  }

  void onSelectdivisionName(Customer result, SearchController controller) {
    if (result.name == null) return;
    controller.text = result.name!;
    _selecteddivisionName = result;
    //_addLocations(result.locations);
    if (result.locations != null) {
      userLocationDropdownController.addItems(result.locations!
          .map((element) => LocationWithQuantityUiModel(location: element))
          .toList()
          .map(
            (e) => DropdownItem(label: "${e.location?.location}", value: e),
          )
          .toList());
      userLocationDropdownController.openDropdown();
    }
  }

  void onClickSenddivisionName() {
    divisionName?.openView();
  }

  Future<void> onSubmitOrder() async {
    if (_selecteddivisionName == null && selectedProduct.value == null) {
      Get.showSnackbar(const GetSnackBar(
          message: "Required values are not available",
          duration: Duration(seconds: 5),
          progressIndicatorValueColor: AlwaysStoppedAnimation(Colors.white)));
      return;
    }

    orderLoading.value = true;

    await Future.delayed(const Duration(seconds: 4));

    orderLoading.value = false;

    Get.showSnackbar(const GetSnackBar(
      message: "Order submitted successfully",
      duration: Duration(seconds: 3),
    ));
  }

  Future<void> onAddItem() async {
    if (_selecteddivisionName == null && selectedProduct.value == null) {
      Get.showSnackbar(const GetSnackBar(
          message: "Required values are not available",
          duration: Duration(seconds: 5),
          progressIndicatorValueColor: AlwaysStoppedAnimation(Colors.white)));
      return;
    }

    addItemLoading.value = true;

    await Future.delayed(const Duration(seconds: 4));

    addItemLoading.value = false;

    Get.showSnackbar(const GetSnackBar(
      message: "Order created successfully",
      duration: Duration(seconds: 3),
    ));

    addedProducts.add(AddedProductUiModel(
        productName: selectedProduct.value?.name,
        unit: selectedUnit?.name?.name,
        packing: selectedPacking?.packing));
  }

  void deleteAddedProduct(AddedProductUiModel request) {
    addedProducts.remove(request);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    userName.value = _session.userDetails?.name ?? "Welcome";
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
