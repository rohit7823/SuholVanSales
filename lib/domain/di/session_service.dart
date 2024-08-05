import 'package:get/get.dart';

class SessionService extends GetxService {
  String? _appToken;

  String? get appToken => _appToken;

  void registerAppToken(String? token) {
    _appToken = token;
  }

  void unregisterAppToken() {
    _appToken = null;
  }
}
