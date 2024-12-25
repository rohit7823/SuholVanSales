import 'package:esc_pos_bluetooth_updated/esc_pos_bluetooth_updated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/app/theme/colors.dart';
import 'package:suhol_van_sales/domain/data_source/remote/material_request/request/material_requisition_request.dart';
import 'package:suhol_van_sales/printer/bluetooh_utills.dart';
import 'package:suhol_van_sales/printer/exts.dart';
import 'package:suhol_van_sales/printer/paired_devices_popup.dart';
import 'package:suhol_van_sales/printer/printer_utils.dart';

class PrintInvoiceScreenController extends GetxController {
  Rx<MaterialRequisitionRequest?> invoiceData = Rx(null);

  Rx<PrinterBluetooth?> selectedDevice = Rx(null);

  final _printer = GenericPrinter();

  Rx<PosPrintResult?> printingStatus = Rx(null);

  Rx<ByteData?> invoice = Rx(null);

  Worker? _worker;

  @override
  void onInit() {
    super.onInit();
    _printer.setup();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    invoiceData.value = Get.arguments;
    /*rootBundle.load(Images.invoiceTemplate).then(
      (value) {
        invoice.value = value;
      },
    );*/
  }

  void selectDevice() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        PairedDevicesPopup.getInstance().show(
          printer: _printer,
          onDeviceConnect: onDeviceConnection,
          selectedDevice: selectedDevice,
        );
      },
    );
  }

  void print(GlobalKey invoiceKey) async {
    var bytes = await captureImage(invoiceKey);
    if (bytes != null) {
      Get.showSnackbar(const GetSnackBar(
        message: "Starting......",
        duration: Duration(seconds: 3),
        overlayBlur: .5,
        isDismissible: false,
        showProgressIndicator: true,
        progressIndicatorValueColor:
            AlwaysStoppedAnimation(AppColors.secondary),
      ));
      printingStatus.value = await _printer.printImageIfConnected(bytes);
      Get.showSnackbar(GetSnackBar(
        message: "${printingStatus.value?.msg}",
        duration: const Duration(seconds: 3),
        overlayBlur: .5,
        isDismissible: false,
        showProgressIndicator: true,
        progressIndicatorValueColor:
            const AlwaysStoppedAnimation(AppColors.primary),
      ));
    }
  }

  void _printSample() async {}

  void onDeviceConnection(PrinterBluetooth device) async {
    if (Get.isOverlaysOpen) {
      Navigator.of(Get.overlayContext!).pop();
    }
    if (selectedDevice.value == device) {
      var isDisconnected = await BluetoohUtills.instance.disconnect();
      if (isDisconnected) {
        _printer.selectPrinter(null);
        Get.showSnackbar(GetSnackBar(
          message: "Disconnection Successful ${selectedDevice.value?.name}",
          duration: const Duration(seconds: 3),
        ));
        selectedDevice.value = null;
      }
    } else {
      _printer.selectPrinter(device);
      selectedDevice.value = device;
      Get.showSnackbar(GetSnackBar(
        message: "Connection Successful with ${device.name}",
        duration: const Duration(seconds: 5),
      ));
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
