import 'package:esc_pos_bluetooth_updated/esc_pos_bluetooth_updated.dart';
import 'package:esc_pos_utils_updated/esc_pos_utils_updated.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';

class GenericPrinter {
  CapabilityProfile? _profile;
  Generator? _generator;
  PrinterBluetoothManager? _printerBluetoothManager;
  PrinterBluetooth? _selectedPrinter;

  PrinterBluetooth? get selectedPrinter => _selectedPrinter;

  void get startScanForFiveMin =>
      _printerBluetoothManager?.startScan(const Duration(minutes: 5));

  void get stopScan => _printerBluetoothManager?.stopScan();

  Stream<List<PrinterBluetooth>>? get printers =>
      _printerBluetoothManager?.scanResults;

  Stream<bool>? get isScanStarted => _printerBluetoothManager?.isScanningStream;

  Future<void> setup() async {
    _profile = await CapabilityProfile.load();
    _generator = Generator(PaperSize.mm58, _profile!);
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
    List<int>? rawBytes = [];

    if (image != null) {
      _generator?.beep(n: 1);
      rawBytes = _generator!.image(image);
      rawBytes += _generator!.cut();
      clearBuffer;
      return await _printerBluetoothManager?.printTicket(rawBytes);
    }
    return null;
  }

  List<int>? get clearBuffer => _generator?.reset();
}
