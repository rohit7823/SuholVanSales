import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:suhol_van_sales/printer/bluetooh_utills.dart';

class GenericPrinter {
  CapabilityProfile? _profile;
  Generator? _generator;

  Future<void> setup() async {
    _profile = await CapabilityProfile.load();
    _generator = Generator(PaperSize.mm80, _profile!);
  }

  Future<List<int>?> printImageIfConnected(ByteData imageData) async {
    var isConnected = await BluetoohUtills.instance.connectionState;

    if (!isConnected) throw Exception("Device is not connected with bluetooth");

    Uint8List bytes = imageData.buffer.asUint8List();
    var image = decodeImage(bytes);

    if (image != null) {
      _generator?.beep(n: 1);
      return _generator?.image(image);
    }
    return null;
  }

  List<int>? get clearBuffer => _generator?.reset();
}
