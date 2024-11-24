import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/domain/di/service_error_logger.dart';

class RestService extends GetxService {
  Dio? _instance;

  Dio? get instance => _instance;

  ServiceErrorLogger logger = ServiceErrorLogger();

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
      )
      ..interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          log("InRequest: API - ${options.uri.toString()}\nREQUEST - ${options.data}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          log("InResponse: API - ${response.realUri.toString()} RESPONSE - ${response.data}");
          return handler.next(response);
        },
        onError: (error, handler) {
          logger.logError(error, null, error.requestOptions);
          return handler.next(error);
        },
      ));
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
