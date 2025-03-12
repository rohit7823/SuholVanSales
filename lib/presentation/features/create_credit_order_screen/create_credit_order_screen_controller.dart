import 'dart:async';
import 'dart:developer';

import 'package:esc_pos_bluetooth_updated/esc_pos_bluetooth_updated.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:suhol_van_sales/app/theme/colors.dart';
import 'package:suhol_van_sales/data/repo_impls/create_order_repository_impl.dart';
import 'package:suhol_van_sales/domain/data_source/remote/material_request/request/material_requisition_request.dart';
import 'package:suhol_van_sales/domain/di/session_service.dart';
import 'package:suhol_van_sales/domain/models/order.dart';
import 'package:suhol_van_sales/domain/utils/response.dart';
import 'package:suhol_van_sales/presentation/models/added_product_ui_model.dart';
import 'package:suhol_van_sales/presentation/models/location_with_quantity_ui_model.dart';
import 'package:suhol_van_sales/presentation/navigation/routes.dart';
import 'package:suhol_van_sales/presentation/utils/number_text_input_formatter.dart';
import 'package:suhol_van_sales/presentation/widgets/animated_progress.dart';
import 'package:suhol_van_sales/presentation/widgets/app_text_field.dart';
import 'package:suhol_van_sales/printer/printer_utils.dart';

import '../../../app/theme/fonts.dart';
import '../../../domain/models/customer.dart';
import '../../../domain/models/product.dart';
import '../../widgets/app_button.dart';

class CreateCreditOrderScreenController extends GetxController {
  final _repo = Get.find<CreateOrderRepositoryImpl>();
  final _session = Get.find<SessionService>();
  final _printer = GenericPrinter();

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

  RxList<Customer> customers = RxList.empty();

  RxList<Order> pickupOrders = RxList.empty();

  RxList<LocationWithQuantityUiModel> selectedLocations = RxList.empty();
  RxList<LocationWithQuantityUiModel> removedLocations = RxList.empty();

  RxList<AddedProductUiModel> addedProducts = RxList.empty();

  RxList<BluetoothInfo> pairedDevices = RxList.empty();

  Rx<PrinterBluetooth?> selectedDevice = Rx(null);

  Worker? _pairedDevicesWorker;

  Worker? _pickupOrderWorker;

  var items = '0'.obs;

  var vat = "OMR 0.000".obs;

  var total = "OMR 0.000".obs;

  Customer? _selectedCustomer;

  var loadingCustomers = false.obs;

  var userLocationDropdownController =
      MultiSelectController<LocationWithQuantityUiModel>();

  Stream<PosPrintResult?>? printingStatus;

  MaterialRequisitionRequest? _requisitionRequest;

  @override
  void onReady() {
    super.onReady();
    qty?.addListener(_onQtyChange);
    price?.addListener(_calculatePrice);
    userName.value = _session.userDetails?.name ?? "Welcome";

    _pickupOrderWorker = ever(
      pickupOrders,
      (orders) {
        if (orders.isNotEmpty) {
          Get.defaultDialog(
            title: "Last Pickup Orders",
            contentPadding: const EdgeInsets.all(5),
            titlePadding: const EdgeInsets.symmetric(vertical: 5),
            radius: 8,
            cancel: InkWell(
                onTap: () {
                  if (Get.overlayContext != null) {
                    Navigator.of(Get.overlayContext!).pop();
                  }
                },
                child: Text(
                  "Close",
                  style: Get.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.redAccent),
                )),
            content: Flexible(
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => ListTile(
                        style: ListTileStyle.list,
                        contentPadding: const EdgeInsets.all(5),
                        titleAlignment: ListTileTitleAlignment.titleHeight,
                        minVerticalPadding: 5,
                        title: Text(
                          "${orders[index].toJson()}",
                          style: Get.textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 5,
                      ),
                  itemCount: orders.length),
            ),
          );
        }
      },
    );
  }

  Future<void> goToPrintInvoice() async {
    var result = await Get.toNamed(Routes.printInvoice.name,
        arguments: _requisitionRequest);
    if (result != null) {}
  }

  void _calculatePrice() {
    var q = double.tryParse(qty?.text ?? '0.00');
    var p = double.tryParse(price?.text ?? '0.00');
    if (q != null && p != null) {
      total.value = (q * p).toStringAsPrecision(3);
    }
  }

  void _onQtyChange() {
    items.value = "${addedProducts.length}";
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
    _pickupOrderWorker?.dispose();
    _pairedDevicesWorker?.dispose();
    _pairedDevicesWorker = null;
    _pickupOrderWorker = null;
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

  var orderLoading = false.obs;
  var addItemLoading = false.obs;

  void addIdWiseQuantities() {
    if (_selectedCustomer == null ||
        selectedLocations.every((element) => element.location?.id == null) ||
        selectedProduct.value == null ||
        selectedUnit == null ||
        selectedPacking == null ||
        qty?.text.isBlank == true ||
        price?.text.isNum == false) {
      Get.showSnackbar(const GetSnackBar(
          message: "Important values are not available",
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
    );

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
          goToPrintInvoice();
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
                  id: element.location?.id,
                  qty: int.tryParse(element.qty.text)),
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
              )));
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

  void _clearValues() {
    _selectedCustomer = null;
    selectedProduct.value = null;
    selectedPacking = null;
    selectedUnit = null;
    selectedLocations.clear();
    remarks?.text = "";
    customerName?.text = '';
    customerLocation?.text = '';
    qty?.text = '';
    unit?.text = '';
    mobileNumber?.text = '';
    vehicleNumber?.text = '';
    productName?.text = '';
    packing?.text = '';
    price?.text = '';
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

  void removeLocation(LocationWithQuantityUiModel? location) {
    selectedLocations.remove(location);
    if (location != null) {
      removedLocations.add(location);
    }
  }

  /*FutureOr<Iterable<Customer>> findCustomerLocation(
      SearchController searchController) async {
    if (searchController.text.isBlank == true) {
      return [];
    }
    AnimatedProgress.showProgressIfNot();
    var values = await _repo.findCustomerByLocation(searchController.text);
    AnimatedProgress.closeProgressIfShowing();
    return values ?? [];
  }*/

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
    if (searchController.text.isBlank == true) {
      return [];
    }

    AnimatedProgress.showProgressIfNot();
    var values = await _repo.findProductByName(searchController.text);
    AnimatedProgress.closeProgressIfShowing();
    return values ?? [];
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

  void onLocationChanged(String value, {Location? location}) {
    if (value.isBlank == false && value.endsWith(" ")) {
      var loc = Location(location: value);
      selectedLocations.insert(0, LocationWithQuantityUiModel(location: loc));
      customerLocation?.clear();
    } else if (location != null) {
      selectedLocations.add(LocationWithQuantityUiModel(location: location));
    }
  }

  void deleteAddedProduct(AddedProductUiModel request) {
    addedProducts.remove(request);
  }

  Future<void> lastPickupOrders(String customerID,
      {void Function(bool state)? loading}) async {
    loading?.call(true);
    var response = await _repo.lastPickupOrders(customerID);
    loading?.call(false);
    if (response is Success) {
      if (response.data?.success case true) {
        var orders = response.data?.data;
        pickupOrders.value = orders ?? [];
      } else {
        Get.showSnackbar(GetSnackBar(
          message: "${response.data?.message ?? response.message}",
          duration: const Duration(seconds: 5),
        ));
      }
    } else {
      Get.showSnackbar(GetSnackBar(
        message: "${response.data?.message ?? response.message}",
        duration: const Duration(seconds: 5),
      ));
    }
  }

  void onSelectionLocation(List<LocationWithQuantityUiModel> selectedItems) {
    selectedLocations.value = selectedItems;
    log("selectedLocations.value $selectedLocations");
  }

  void editAddedProduct(AddedProductUiModel product) {}
}
