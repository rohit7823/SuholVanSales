import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/domain/di/session_service.dart';
import 'package:suhol_van_sales/presentation/navigation/routes.dart';

class AuthMiddleware extends GetMiddleware {
  final _session = Get.find<SessionService>();

  @override
  RouteSettings? redirect(String? route) {
    var token = _session.appToken;
    if (token == null) {
      return null;
    }

    return RouteSettings(name: Routes.home.name);
  }
}
