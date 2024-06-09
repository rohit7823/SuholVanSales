import 'package:dio/dio.dart';
import 'package:get/get.dart';

class RestService extends GetxService {
  Dio? _instance;

  Dio? get instance => _instance;

  Future<RestService> init() async {
    _instance = Dio()
      //..interceptors.add(alice.getDioInterceptor())
      ..options = BaseOptions(
        baseUrl: 'https://api.npoint.io',
        connectTimeout: const Duration(seconds: 10),
        followRedirects: true,
        contentType: "application/json",
        persistentConnection: true,
      );
    return this;
  }

  void updateBaseUrl(String url) {
    _instance?.options = _instance!.options.copyWith(baseUrl: url);
  }

  @override
  void onClose() {
    _instance?.close(force: true);
    _instance = null;
    super.onClose();
  }
}
