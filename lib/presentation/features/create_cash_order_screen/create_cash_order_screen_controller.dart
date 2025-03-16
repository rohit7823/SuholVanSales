import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:suhol_van_sales/domain/di/session_service.dart';
import 'package:suhol_van_sales/domain/models/customer.dart';
import 'package:suhol_van_sales/domain/models/product.dart';
import 'package:suhol_van_sales/domain/utils/response.dart';
import 'package:suhol_van_sales/presentation/models/location_with_quantity_ui_model.dart';

import '../../../data/repo_impls/create_order_repository_impl.dart';
import '../../../domain/data_source/remote/material_request/request/material_requisition_request.dart';
import '../../models/added_product_ui_model.dart';
import '../../widgets/animated_progress.dart';

class CreateCashOrderScreenController extends GetxController {
  final _repo = Get.find<CreateOrderRepositoryImpl>();
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
  RxList<MaterialRequisitionRequest> addedMaterialRequests = RxList.empty();

  var userLocationDropdownController =
      MultiSelectController<LocationWithQuantityUiModel>();

  RxList<LocationWithQuantityUiModel> selectedLocations = RxList.empty();

  MaterialRequisitionRequest? _requisitionRequest;

  RxList<AddedProductUiModel> addedProducts = RxList.empty();

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

  void onSelectionLocation(List<LocationWithQuantityUiModel> selectedItems) {
    selectedLocations.value = selectedItems;
    log("selectedLocations.value $selectedLocations");
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    qty?.removeListener(_onQtyChange);
    price?.removeListener(_calculatePrice);
    customerName?.dispose();
    vehicleNumber?.dispose();
    mobileNumber?.dispose();
    productName?.dispose();
    unit?.dispose();
    qty?.dispose();
    price?.dispose();
    remarks?.dispose();
    customerName = null;
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

  var orderLoading = false.obs;

  var addItemLoading = false.obs;

  Future<void> onSubmitOrder() async {
    if (vehicleNumber?.text.isBlank == true) {
      Get.showSnackbar(const GetSnackBar(
        message: "Vehicle no is not given.",
        duration: Duration(seconds: 5),
      ));
      return;
    }

    _requisitionRequest = MaterialRequisitionRequest(
        customerId: _selectedCustomer?.id,
        customerName: _selectedCustomer?.name,
        productName: selectedProduct.value?.name,
        phoneNo: int.tryParse(mobileNumber?.text ?? ""),
        productUnit: selectedUnit?.name?.name,
        productPacking: selectedPacking?.packing,
        price: double.tryParse(price?.text ?? '0.00'),
        productId: selectedProduct.value?.id,
        packingId: selectedPacking?.id,
        vehicleNo: vehicleNumber?.text,
        deliveryDate: DateTime.now(),
        remarks: remarks?.text,
        unitOfMeasurementId: selectedUnit?.id,
        quantity: int.tryParse("${qty?.text}"),
        paymentModeType: 'cash');

    orderLoading.value = true;
    var result = await _repo.createRequisition(_requisitionRequest!);
    orderLoading.value = false;
    if (result is Success) {
      switch (result.data?.success) {
        case true:
          /*await Future.delayed(const Duration(milliseconds: 500)).then(
            (value) {
              Get.back();
            },
          );*/
          //goToPrintInvoice();
          Get.showSnackbar(GetSnackBar(
            message: "${result.data?.message}",
            duration: const Duration(seconds: 5),
          ));
          break;
        case false:
          Get.showSnackbar(GetSnackBar(
            message: "${result.data?.message ?? result.data?.error}",
            duration: const Duration(seconds: 5),
          ));
        case null:
          Get.showSnackbar(GetSnackBar(
            message: "${result.data?.message ?? result.data?.error}",
            duration: const Duration(seconds: 5),
          ));
          break;
      }
    } else if (result is Error) {
      Get.showSnackbar(GetSnackBar(
        message: "${result.message}",
        duration: const Duration(seconds: 5),
      ));
    }
  }

  Future<void> onAddItem() async {
    if (_selectedCustomer == null ||
        selectedLocations.every((element) => element.location?.id == null) ||
        selectedProduct.value == null ||
        selectedUnit == null ||
        selectedPacking == null ||
        vehicleNumber?.text.isBlank == true ||
        mobileNumber?.text.isNum == false) {
      Get.showSnackbar(const GetSnackBar(
          message: "Important values are not available",
          duration: Duration(seconds: 5),
          progressIndicatorValueColor: AlwaysStoppedAnimation(Colors.white)));
      return;
    }

    addItemLoading.value = true;
    _requisitionRequest = MaterialRequisitionRequest(
        customerName: _selectedCustomer?.name,
        phoneNo: int.tryParse(mobileNumber?.text ?? ""),
        productUnit: selectedUnit?.name?.name,
        productPacking: selectedPacking?.packing,
        customerId: _selectedCustomer?.id,
        productId: selectedProduct.value?.id,
        packingId: selectedPacking?.id,
        vehicleNo: vehicleNumber?.text,
        deliveryDate: DateTime.now(),
        price: double.tryParse(price?.text ?? '0.00'),
        remarks: remarks?.text,
        unitOfMeasurementId: selectedUnit?.id,
        quantity: int.tryParse("${qty?.text}"),
        locationIdsWithQuantity: selectedLocations
            .map(
              (element) => LocationIDWithQuantity(
                  id: element.location?.id, qty: int.tryParse(qty?.text ?? '')),
            )
            .toList());
    var result = await _repo.createRequisitionOrder(_requisitionRequest!);
    addItemLoading.value = false;
    if (result is Success) {
      switch (result.data?.success) {
        case true:
          /*await Future.delayed(const Duration(milliseconds: 500)).then(
            (value) {
              Get.back();
            },
          );*/

          Get.showSnackbar(GetSnackBar(
            message: "${result.data?.message}",
            duration: const Duration(seconds: 5),
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
              allDetails: _requisitionRequest));
          //_clearValues();
          break;
        case false:
          Get.showSnackbar(GetSnackBar(
            message: "${result.data?.message ?? result.data?.error}",
            duration: const Duration(seconds: 5),
          ));
        case null:
          Get.showSnackbar(GetSnackBar(
            message: "${result.data?.message ?? result.data?.error}",
            duration: const Duration(seconds: 5),
          ));
          break;
      }
    } else if (result is Error) {
      Get.showSnackbar(GetSnackBar(
        message: "${result.message}",
        duration: const Duration(seconds: 5),
      ));
    }
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

  void deleteAddedProduct(AddedProductUiModel request) {
    addedProducts.remove(request);
  }

  /* void addIdWiseQuantities() {


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
  }*/

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

  void onSelectProduct(Product result, SearchController controller) {
    if (result.name == null) return;
    controller.text = result.name ?? result.alias ?? "";
    selectedProduct.value = result;
    clearSelectedPacking();
    clearSelectedUnit();
  }

  // FutureOr<Iterable<Customer>> findCustomerEmail(
  //     SearchController searchController) async {
  //   var values = await _repo.findCustomerByEmail(searchController.text);
  //   return values ?? [];
  // }

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

  void editAddedProduct(AddedProductUiModel product) {
    final productDetails = product.allDetails;
    if (productDetails != null) {
      customerName?.text = productDetails.customerName ?? '';
      productName?.text = productDetails.productName ?? '';
      packing?.text = productDetails.packing?.packing ?? '';
      unit?.text = productDetails.unit?.name?.name ?? '';
      _selectedCustomer = productDetails.customer;
      selectedProduct.value = productDetails.product;
      mobileNumber?.text = productDetails.phoneNo?.toString() ?? '';
      selectedUnit = productDetails.unit;
      selectedPacking = productDetails.packing;
      vehicleNumber?.text = productDetails.vehicleNo ?? '';
      remarks?.text = productDetails.remarks ?? '';
      qty?.text = productDetails.quantity?.toString() ?? '';

      final items = productDetails.locationIdsWithQuantity?.map(
            (e) => LocationWithQuantityUiModel(
              location: e.loc,
            ),
          ) ??
          [];

      userLocationDropdownController.addItems(items
          .map(
            (e) => DropdownItem(label: e.location?.location ?? '', value: e),
          )
          .toList());
      selectedLocations.value = items.toList();

      addedProducts.remove(product);
    }
  }
}
