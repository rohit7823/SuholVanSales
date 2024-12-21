import 'package:esc_pos_bluetooth_updated/esc_pos_bluetooth_updated.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/app/theme/images.dart';
import 'package:suhol_van_sales/domain/data_source/remote/material_request/request/material_requisition_request.dart';
import 'package:suhol_van_sales/printer/bluetooh_utills.dart';
import 'package:suhol_van_sales/printer/exts.dart';
import 'package:suhol_van_sales/printer/paired_devices_popup.dart';
import 'package:suhol_van_sales/printer/printer_utils.dart';

class PrintInvoiceScreenController extends GetxController {
  MaterialRequisitionRequest? _invoiceData;

  Rx<PrinterBluetooth?> selectedDevice = Rx(null);

  final _printer = GenericPrinter();

  Stream<PosPrintResult?>? printingStatus;

  Rx<ByteData?> invoice = Rx(null);

  @override
  void onInit() {
    super.onInit();
    _printer.setup();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _invoiceData = Get.arguments;
    rootBundle.load(Images.invoiceTemplate).then(
      (value) {
        invoice.value = value;
      },
    );
  }

  void print(GlobalKey invoiceKey) {
    PairedDevicesPopup.getInstance().show(
      printer: _printer,
      onDeviceConnect: onDeviceConnection,
      selectedDevice: selectedDevice,
      printStatus: printingStatus,
      onPrint: () {
        debugPrint("PRINT CLICKED !!!");
        captureImage(invoiceKey).then(
          (value) {
            if (value != null) {
              printingStatus =
                  _printer.printImageIfConnected(value)?.asStream();
            }
          },
        );
      },
    );
  }

  void _printSample() async {}

  void onDeviceConnection(PrinterBluetooth device) async {
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
