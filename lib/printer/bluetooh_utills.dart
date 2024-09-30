import 'package:app_settings/app_settings.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class BluetoohUtills {
  const BluetoohUtills._();

  static const BluetoohUtills instance = BluetoohUtills._();

  Future<bool> get isPermissionGranted async =>
      await PrintBluetoothThermal.isPermissionBluetoothGranted;

  Future<bool> get isBluetoothEnabled async =>
      await PrintBluetoothThermal.bluetoothEnabled;

  Future<bool> get connectionState async =>
      await PrintBluetoothThermal.connectionStatus;

  Future<List<BluetoothInfo>> pairedBluetooth() async {
    var paired = await PrintBluetoothThermal.pairedBluetooths;
    return paired;
  }

  Future<bool> connect({required String printerAddress}) async =>
      await PrintBluetoothThermal.connect(macPrinterAddress: printerAddress);

  Future<bool> disconnect() async {
    return await PrintBluetoothThermal.disconnect;
  }

  Future<int> get batteryLevel async =>
      await PrintBluetoothThermal.batteryLevel;

  Future<void> openBluetoothSettings() async {
    await AppSettings.openAppSettings(
        asAnotherTask: false, type: AppSettingsType.settings);
    //await AppSettings.openAppSettingsPanel(AppSettingsPanelType.)
  }
}
