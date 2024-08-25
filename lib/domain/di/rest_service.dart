import 'package:dio/dio.dart';
import 'package:get/get.dart';

class RestService extends GetxService {
  Dio? _instance;

  Dio? get instance => _instance;

  Future<RestService> init() async {
    _instance = Dio()
      //..interceptors.add(alice.getDioInterceptor())
      ..options = BaseOptions(
          baseUrl: 'http://demoapp.souqsuhol.com/api',
          connectTimeout: const Duration(seconds: 10),
          followRedirects: true,
          contentType: "application/json",
          persistentConnection: true,
          headers: _staticHeaders(),
          validateStatus: (status) => true,
      );
    return this;
  }

  Map<String, dynamic> _staticHeaders() {
    return {"Accept": "application/json", "Content-Type": "application/json"};
  }

  void addAuthHeader(String? bearerToken) {
    var headers = _staticHeaders();
    headers.addIf(() => true, "Authorization", "Bearer $bearerToken");

    _instance?.options = _instance!.options.copyWith(headers: headers);
  }

  void removeAuthHeader() {
    _instance?.options = _instance!.options.copyWith(headers: _staticHeaders());
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
