import 'package:get/get.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class DeviceInfoWithState {
  BluetoothInfo? data;
  RxBool state = false.obs;
  RxBool showPrint = false.obs;

  DeviceInfoWithState({
    this.data,
  });

  void updateState(bool value) {
    state.value = value;
  }

  void shouldShowPrint(bool isConnected) {
    showPrint.value = isConnected;
  }
}
