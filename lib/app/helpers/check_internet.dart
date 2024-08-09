import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart' as rx;

typedef RecieveStateCallback = Future<T> Function<T>(bool state);

class ConnectivityService extends GetxService {
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  rx.Rx<ConnectivityResult> state = rx.Rx(ConnectivityResult.none);

  void checkNow(RecieveStateCallback receiveStateCallback) async {
    var connectivity = Connectivity();
    var results = await connectivity.checkConnectivity();
    receiveStateCallback(results.last != ConnectivityResult.none);

    _subscription = connectivity.onConnectivityChanged.listen((event) {
      receiveStateCallback.call(results.last != ConnectivityResult.none);
      state.value = event.first;
    });
  }

  Future<bool> isConnected() async {
    var result = await Connectivity().checkConnectivity();
    return result.last != ConnectivityResult.none;
  }

  disposeInternetSubscription() {
    if (_subscription == null) return;
    _subscription?.cancel();
  }

  @override
  void onClose() {
    super.onClose();
    disposeInternetSubscription();
  }
}
