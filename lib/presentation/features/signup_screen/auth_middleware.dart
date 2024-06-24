import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/domain/di/preference_service.dart';
import 'package:suhol_van_sales/presentation/navigation/routes.dart';

class AuthMiddleware extends GetMiddleware {
  final _prefs = Get.find<PreferenceService>();

  @override
  RouteSettings? redirect(String? route) {
    var userId = _prefs.userID;
    if (userId.isBlank == true) {
      return null;
    }

    return RouteSettings(name: Routes.home.name);
  }
}
