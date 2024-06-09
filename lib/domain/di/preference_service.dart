import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService extends GetxService {
  SharedPreferences? _preferences;

  static const _baseUrlKey = 'BASE_URL';
  static const _userId = "USER_ID";
  static const _loginStatus = "LOGIN_STATUS";

  Future<PreferenceService> init() async {
    _preferences = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setBaseUrl(String url) {
    return _preferences!.setString(_baseUrlKey, url);
  }

  Future<String?> get baseUrl async => _preferences!.getString(_baseUrlKey);

  Future<bool> userId(String id) {
    return _preferences!.setString(_userId, id);
  }

  String get userID => _preferences!.getString(_userId) ?? "";

  Future<bool> changeLoginState(bool state) {
    return _preferences!.setBool(_loginStatus, state);
  }

  bool get loginStatus {
    return _preferences!.getBool(_loginStatus) ?? false;
  }

  @override
  void onClose() {
    _preferences = null;
    super.onClose();
  }
}
