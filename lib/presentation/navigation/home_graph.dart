import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/presentation/features/cash_sales_order/cash_sales_order_binding.dart';
import 'package:suhol_van_sales/presentation/features/cash_sales_order/cash_sales_order_view.dart';
import 'package:suhol_van_sales/presentation/features/credit_sales_order/credit_sales_order_binding.dart';
import 'package:suhol_van_sales/presentation/features/credit_sales_order/credit_sales_order_view.dart';
import 'package:suhol_van_sales/presentation/features/dashboard/dashboard_binding.dart';
import 'package:suhol_van_sales/presentation/features/dashboard/dashboard_screen.dart';

import 'routes.dart';

class HomeGraph {
  HomeGraph._();

  static HomeGraph instance = HomeGraph._();

  int navKey = 1705;

  Route<Routes>? routes(RouteSettings settings) {
    var name = settings.name;
    var arguments = settings.arguments;

    var route = Routes.values.firstWhereOrNull((r) => r.name == name);

    switch (route) {
      case Routes.dashboard:
        return _generatePageRoute(
          page: const DashboardScreen(),
          binding: DashboardBinding(),
          settings: settings,
          maintainState: true,
          routeName: name,
        );
      case Routes.creditSalesOrder:
        return _generatePageRoute(
          page: const CreditSalesOrder(),
          binding: CreditSalesOrderBinding(),
          settings: settings,
          maintainState: false,
          routeName: name,
        );
      case Routes.cashSalesOrder:
        return _generatePageRoute(
          page: const CashSalesOrder(),
          binding: CashSalesOrderBinding(),
          settings: settings,
          maintainState: false,
          routeName: name,
        );
      default:
        return null;
    }
  }

  void pop<T>({T? result, bool? closeOverlays, bool? canPop}) {
    Get.back<T>(
        id: navKey,
        result: result,
        closeOverlays: closeOverlays ?? false,
        canPop: canPop ?? false);
  }

  GetPageRoute<Routes> _generatePageRoute(
          {required Widget page,
          required Bindings binding,
          bool? maintainState,
          Map<String, String>? arguments,
          required RouteSettings settings,
          String? routeName}) =>
      GetPageRoute(
        page: () => page,
        binding: binding,
        maintainState: maintainState ?? false,
        parameter: arguments,
        settings: settings,
        routeName: routeName,
        transition: Transition.rightToLeftWithFade,
        alignment: Alignment.center,
        curve: Curves.fastLinearToSlowEaseIn,
        transitionDuration: const Duration(milliseconds: 600),
      );
}
