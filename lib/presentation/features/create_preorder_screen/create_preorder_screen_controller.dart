import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:suhol_van_sales/app/theme/colors.dart';
import 'package:suhol_van_sales/app/theme/fonts.dart';
import 'package:suhol_van_sales/data/repo_impls/create_credit_order_repository_impl.dart';
import 'package:suhol_van_sales/domain/di/session_service.dart';
import 'package:suhol_van_sales/domain/models/customer.dart';
import 'package:suhol_van_sales/domain/models/product.dart';
import 'package:suhol_van_sales/presentation/models/added_product_ui_model.dart';
import 'package:suhol_van_sales/presentation/models/location_with_quantity_ui_model.dart';
import 'package:suhol_van_sales/presentation/utils/number_text_input_formatter.dart';
import 'package:suhol_van_sales/presentation/widgets/animated_progress.dart';
import 'package:suhol_van_sales/presentation/widgets/app_button.dart';
import 'package:suhol_van_sales/presentation/widgets/app_text_field.dart';

class CreatePreorderScreenController extends GetxController {
  final _repo = Get.find<CreateCreditOrderRepositoryImpl>();
  final _session = Get.find<SessionService>();
  var userName = ''.obs;

  var shopName = ''.obs;

  SearchController? customerName = SearchController();

  Customer? _selectedCustomer;

  var userLocationDropdownController =
      MultiSelectController<LocationWithQuantityUiModel>();

  RxList<LocationWithQuantityUiModel> selectedLocations = RxList.empty();

  RxList<AddedProductUiModel> addedProducts = RxList.empty();

  SearchController? productName = SearchController();
  Rx<Product?> selectedProduct = Rx(null);
  SearchController? packing = SearchController();

  SearchController? unit = SearchController();

  Packing? selectedPacking;

  UnitElement? selectedUnit;

  TextEditingController? price = TextEditingController();

  TextEditingController? remarks = TextEditingController();

  TextEditingController? qty = TextEditingController();

  TextEditingController? deliveryDateUi = TextEditingController();

  TextEditingController? deliveryTimeUi = TextEditingController();

  DateTime? _deliveryDate;
  TimeOfDay? _deliveryTime;

  var orderLoading = false.obs;
  var addItemLoading = false.obs;

  void pop() {
    Get.back();
  }

  FutureOr<Iterable<Customer>> findCustomerName(
      SearchController searchController) async {
    if (searchController.text.isBlank == true) {
      return [];
    }

    AnimatedProgress.showProgressIfNot();
    var values = await _repo.findCustomerByName(searchController.text);
    AnimatedProgress.closeProgressIfShowing();

    return values ?? [];
  }

  void onSelectCustomer(Customer result, SearchController controller) {
    if (result.name == null) return;
    controller.text = result.name!;
    _selectedCustomer = result;
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

  void onClickSendCustomerName() {
    customerName?.openView();
  }

  void onSelectionLocation(List<LocationWithQuantityUiModel> selectedItems) {
    selectedLocations.value = selectedItems;
    log("selectedLocations.value ${selectedLocations}");
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

  Future<void> onSubmitOrder() async {
    if (_deliveryDate != null) {
      Get.showSnackbar(const GetSnackBar(
        message: "Delivery date is not given",
        duration: Duration(seconds: 5),
      ));
      return;
    }

    if (_deliveryTime != null) {
      Get.showSnackbar(const GetSnackBar(
        message: "Delivery time is not given",
        duration: Duration(seconds: 5),
      ));
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

  Future<void> onAddItem() async {
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
        packing: selectedPacking?.packing,
        quantity: selectedLocations.fold(
          0,
          (previousValue, element) =>
              previousValue! + (int.tryParse(element.qty.text) ?? 0),
        ),
        deliveryTime: _deliveryTime,
        deliveryDate: _deliveryDate));
  }

  void insertDeliveryDate(DateTime? date) {
    if (date != null) {
      var formattedDate = DateFormat('dd/MM/yyyy').format(date);
      deliveryDateUi?.text = formattedDate;
      _deliveryDate = date;
    }
  }

  void insertDeliveryTime(TimeOfDay? time) {
    if (time != null) {
      deliveryTimeUi?.text = "${time.hour}:${time.minute}";
      _deliveryTime = time;
    }
  }

  void addIdWiseQuantities() {
    if (_selectedCustomer == null ||
        selectedLocations.every((element) => element.location?.id == null) ||
        selectedProduct.value == null ||
        selectedUnit == null ||
        selectedPacking == null ||
        _deliveryDate == null ||
        _deliveryTime == null) {
      Get.showSnackbar(const GetSnackBar(
          message: "Required values are not available",
          duration: Duration(seconds: 5),
          progressIndicatorValueColor: AlwaysStoppedAnimation(Colors.white)));
      return;
    }

    Get.dialog(Dialog(
      insetPadding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      backgroundColor: Colors.white,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  onPressed: () => Navigator.of(Get.overlayContext!).pop(),
                  icon: const Icon(
                    Icons.close,
                    color: Colors.redAccent,
                  )),
            ),
            Flexible(
                child: Obx(
              () => ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    var model = selectedLocations[index];
                    return Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "${model.location?.location}",
                              style: Get.textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            )),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: MyTextField(
                              changeStyle: true,
                              enabled: true,
                              isObscure: false,
                              controller: model.qty,
                              hint: "Enter Qty",
                              inputFormatters: [NumberTextInputFormatter()],
                              keyboardType:
                                  const TextInputType.numberWithOptions()),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 8,
                      ),
                  itemCount: selectedLocations.length,
                  cacheExtent: 50),
            )),
            const SizedBox(
              height: 8,
            ),
            AppButton(
              onClick: () {
                Navigator.of(Get.context!).pop();
                onAddItem();
              },
              btnColor: AppColors.buttonColor,
              border: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              height: 35,
              child: Text(
                "ADD",
                style: Get.textTheme.titleLarge?.copyWith(
                    color: Colors.white, fontFamily: Fonts.poppinsMedium),
              ),
            )
          ],
        ),
      ),
    ));
  }

  void deleteAddedProduct(AddedProductUiModel request) {
    addedProducts.remove(request);
  }
}
