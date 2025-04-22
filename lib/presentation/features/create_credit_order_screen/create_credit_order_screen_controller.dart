import 'dart:async';
import 'dart:developer';

import 'package:esc_pos_bluetooth_updated/esc_pos_bluetooth_updated.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:suhol_van_sales/data/repo_impls/create_order_repository_impl.dart';
import 'package:suhol_van_sales/domain/data_source/remote/material_request/request/material_requisition_request.dart';
import 'package:suhol_van_sales/domain/di/session_service.dart';
import 'package:suhol_van_sales/domain/models/order.dart';
import 'package:suhol_van_sales/domain/utils/response.dart';
import 'package:suhol_van_sales/presentation/models/added_product_ui_model.dart';
import 'package:suhol_van_sales/presentation/models/location_with_quantity_ui_model.dart';
import 'package:suhol_van_sales/presentation/navigation/routes.dart';
import 'package:suhol_van_sales/presentation/widgets/animated_progress.dart';
import 'package:suhol_van_sales/printer/printer_utils.dart';

import '../../../domain/models/customer.dart';
import '../../../domain/models/product.dart';

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
    //mobileNumber?.addListener(_onMobileInput);
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

  void _onMobileInput() {
    if (mobileNumber?.text.isBlank == false) {
      final customer =
          CreateOrderRepositoryImpl.customersCache.firstWhereOrNull(
        (customer) {
          return customer.mobileNumber == mobileNumber?.text;
        },
      );
      if (customer != null) {
        onSelectCustomer(customer, customerName!);
      }
    }
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

  FocusNode? packingFocusNode = FocusNode(canRequestFocus: false);

  //final GlobalKey<MyDropdownState<Packing>> packingNode = GlobalKey();
  FocusNode? unitFocusNode = FocusNode(canRequestFocus: false);
  FocusNode? qtyFocusNode = FocusNode();
  FocusNode? productFocusNode = FocusNode(canRequestFocus: false);

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
      productName?.closeView(productDetails.productName);
      userLocationDropdownController.closeDropdown();
    }
  }

  Future<void> onSubmitOrder() async {
    if (vehicleNumber?.text.isBlank == true) {
      Get.showSnackbar(const GetSnackBar(
        message: "Vehicle no is not given.",
        duration: Duration(seconds: 5),
      ));
      return;
    }

    _requisitionRequest = _requisitionRequest?.copyWith(
      customer: _selectedCustomer,
      product: selectedProduct.value,
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

  void onSelectionLocation(List<LocationWithQuantityUiModel> selectedItems) {
    if (selectedItems.isNotEmpty) {
      selectedLocations.value = selectedItems;
      log("selectedLocations.value $selectedLocations");
      //productFocusNode?.requestFocus();
      //productName?.openView();
    }
  }

  Future<void> onAddItem() async {
    if ((_selectedCustomer == null && customerName?.text.isBlank == true) ||
        // selectedLocations.every((element) => element.location?.id == null) ||
        selectedProduct.value == null ||
        selectedUnit == null ||
        selectedPacking == null ||
        qty?.text.isBlank == true ||
        price?.text.isNum == false) {
      log('CUSTOMER ${_selectedCustomer?.toJson()} -- PRODUCT ${selectedProduct.value} -- UNIT ${selectedUnit?.toJson()} -- ${selectedPacking?.toJson()} -- QTY ${qty?.text} -- PRICE ${price?.text}',
          name: 'VALIDATION');
      Get.showSnackbar(const GetSnackBar(
          message: "Important values are not available",
          duration: Duration(seconds: 5),
          progressIndicatorValueColor: AlwaysStoppedAnimation(Colors.white)));
      return;
    }

    addItemLoading.value = true;

    _requisitionRequest = MaterialRequisitionRequest(
        customer: _selectedCustomer,
        product: selectedProduct.value,
        packing: selectedPacking,
        unit: selectedUnit,
        customerName: _selectedCustomer?.name,
        productName: selectedProduct.value?.name,
        phoneNo: int.tryParse(mobileNumber?.text ?? ""),
        productUnit: selectedUnit?.name?.name,
        productPacking: selectedPacking?.packing,
        customerId: _selectedCustomer?.id ?? 0,
        productId: selectedProduct.value?.id,
        packingId: selectedPacking?.id,
        vehicleNo: vehicleNumber?.text,
        deliveryDate: DateTime.now(),
        price: double.tryParse(price?.text ?? '0.00'),
        remarks: remarks?.text,
        unitOfMeasurementId: selectedUnit?.id,
        quantity: int.tryParse("${qty?.text}"),
        locationIdsWithQuantity: selectedLocations
            .map((element) => LocationIDWithQuantity(
                loc: element.location,
                id: element.location?.id,
                qty: int.tryParse(qty?.text ?? '')))
            .toList()
    );

    var result = await _repo.createRequisitionOrder(_requisitionRequest!);
    addItemLoading.value = false;
    if (result is Success) {
      addedProducts.add(AddedProductUiModel(
          productName: selectedProduct.value?.name,
          unit: selectedUnit?.name?.name,
          packing: selectedPacking?.packing,
          price: double.tryParse(price?.text ?? '0'),
          quantity: int.tryParse(qty?.text ?? ''),
          allDetails: _requisitionRequest));
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

          _clearValues();
          break;
        case false:
          _clearValues();
        /*Get.showSnackbar(GetSnackBar(
            message: "${result.data?.message ?? result.data?.error}",
            duration: const Duration(seconds: 5),
          ));*/
        case null:
          _clearValues();
          /*Get.showSnackbar(GetSnackBar(
            message: "${result.data?.message ?? result.data?.error}",
            duration: const Duration(seconds: 5),
          ));*/
          break;
      }
    } else if (result is Error) {
      _clearValues();
      /*Get.showSnackbar(GetSnackBar(
        message: "${result.message}",
        duration: const Duration(seconds: 5),
      ));*/
    }
  }

  void _clearValues() {
    //_selectedCustomer = null;
    selectedProduct.value = null;
    selectedPacking = null;
    selectedUnit = null;
    //selectedLocations.clear();
    //remarks?.text = "";
    //customerName?.text = '';
    //customerLocation?.text = '';
    qty?.text = '';
    unit?.text = '';
    //mobileNumber?.text = '';
    //vehicleNumber?.text = '';
    productName?.text = '';
    packing?.text = '';
    price?.text = '';
    //userLocationDropdownController.clearAll();
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
    log('${result.mobileNumber}', name: 'CUSTOMER_NUMBER');
    if (result.name == null) return;
    controller.text = result.name!;
    _selectedCustomer = result;
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

  Iterable<Packing> findProductPacking(SearchController controller) {
    //debugPrint("query ${searchController.text}");
    var values = selectedProduct.value?.packings
        ?.where(
          (element) => element.packing?.isCaseInsensitiveContains("") ?? false,
        )
        .toList();
    return values ?? [];
  }

  FutureOr<Iterable<Product>> findProductName(
      SearchController searchController) async {
    if (CreateOrderRepositoryImpl.productsCache.isEmpty) {
      AnimatedProgress.showProgressIfNot();
    }

    var values = await _repo.findProductByName(searchController.text);

    if (CreateOrderRepositoryImpl.productsCache.isEmpty) {
      AnimatedProgress.closeProgressIfShowing();
    }

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

  void onSelectProductPacking(Packing? result, SearchController controller) {
    if (result?.packing == null) return;
    controller.text = result?.packing ?? "None";
    selectedPacking = result;
    unit?.openView();
    unitFocusNode?.unfocus();
  }

  void onSelectProductUnit(UnitElement result, SearchController controller) {
    if (result.name?.name == null) return;
    controller.text = result.name?.name ?? "None";
    selectedUnit = result;
    qtyFocusNode?.requestFocus();
  }

  ///94367877

  void onSelectProduct(Product result, SearchController controller) {
    if (result.name == null) return;
    controller.text = result.name ?? result.alias ?? "";
    selectedProduct.value = result;
    clearSelectedPacking();
    clearSelectedUnit();
    packing?.openView();
    //packingNode.currentState?.toggleDropdown();
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

/*Future<void> lastPickupOrders(String customerID,
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
  }*/
}
