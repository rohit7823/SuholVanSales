import 'dart:developer';

import 'package:esc_pos_bluetooth_updated/esc_pos_bluetooth_updated.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:suhol_van_sales/printer/bluetooh_utills.dart';

class GenericPrinter {
  CapabilityProfile? _profile;
  Generator? _generator;
  PrinterBluetoothManager? _printerBluetoothManager;
  PrinterBluetooth? _selectedPrinter;

  PrinterBluetooth? get selectedPrinter => _selectedPrinter;

  void get startScanForFiveMin =>
      _printerBluetoothManager?.startScan(const Duration(minutes: 1));

  void get stopScan => _printerBluetoothManager?.stopScan();

  Stream<List<BluetoothInfo>>? get devices =>
      BluetoohUtills.instance.pairedBluetooth().asStream();

  Stream<bool>? get isScanStarted => _printerBluetoothManager?.isScanningStream;

  Future<void> setup() async {
    _profile = await CapabilityProfile.load();

    _generator = Generator(PaperSize.mm80, _profile!)
      ..drawer(pin: PosDrawer.pin2);

    _printerBluetoothManager = PrinterBluetoothManager();
  }

  void selectPrinter(PrinterBluetooth? printer) {
    _selectedPrinter = printer;
    if (printer != null) {
      _printerBluetoothManager?.selectPrinter(printer);
    }
  }

  Future<PosPrintResult?>? printImageIfConnected(ByteData imageData) async {
    if (_selectedPrinter == null) {
      throw Exception("Device is not connected with bluetooth");
    }

    Uint8List bytes = imageData.buffer.asUint8List();
    var image = decodeImage(bytes);
    debugPrint("DECODED_IMAGE ${image?.toString()}");
    List<int>? rawBytes = [];

    if (image != null) {
      _generator?.beep(n: 5);
      rawBytes = _generator!.image(image);
      rawBytes += _generator!.cut();
      clearBuffer;
      var status =  await _printerBluetoothManager?.printTicket(rawBytes,
          chunkSizeBytes: 100, queueSleepTimeMs: 5);
      log("${status?.msg}", name: "PRINT_STATUS");

      return status;
    }
    return null;
  }

  List<int>? get clearBuffer => _generator?.reset();
}
