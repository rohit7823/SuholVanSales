import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/presentation/features/create_cash_order_screen/create_cash_order_screen_binding.dart';
import 'package:suhol_van_sales/presentation/features/create_cash_order_screen/create_cash_order_screen_view.dart';
import 'package:suhol_van_sales/presentation/features/create_credit_order_screen/create_credit_order_screen_binding.dart';
import 'package:suhol_van_sales/presentation/features/create_credit_order_screen/create_credit_order_screen_view.dart';
import 'package:suhol_van_sales/presentation/features/home_screen/home_screen_binding.dart';
import 'package:suhol_van_sales/presentation/features/home_screen/home_screen_view.dart';
import 'package:suhol_van_sales/presentation/features/signup_screen/auth_middleware.dart';
import 'package:suhol_van_sales/presentation/features/signup_screen/signup_screen_binding.dart';
import 'package:suhol_van_sales/presentation/features/signup_screen/signup_screen_view.dart';
import 'package:suhol_van_sales/presentation/navigation/routes.dart';

class MainGraph {
  MainGraph._();

  static MainGraph get instance => MainGraph._();

  List<GetPage> routes() => [
        GetPage<Routes>(
            name: Routes.home.name,
            page: () => const HomeScreen(),
            binding: HomeScreenBinding(),
            maintainState: true,
            popGesture: false,
            preventDuplicates: true,
            fullscreenDialog: true,
            transition: Transition.native,
            curve: Curves.slowMiddle,
            participatesInRootNavigator: true),
        GetPage<Routes>(
            name: Routes.createCreditOrder.name,
            page: () => const CreateCreditOrderScreen(),
            binding: CreateCreditOrderScreenBinding(),
            maintainState: true,
            popGesture: false,
            fullscreenDialog: true,
            preventDuplicates: true,
            transition: Transition.topLevel,
            transitionDuration: const Duration(milliseconds: 600),
            participatesInRootNavigator: true),
        GetPage<Routes>(
          name: Routes.createCashOrder.name,
          page: () => const CreateCashOrderScreen(),
          binding: CreateCashOrderScreenBinding(),
          maintainState: false,
          popGesture: false,
          preventDuplicates: true,
          fullscreenDialog: true,
          transition: Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 600),
          alignment: Alignment.center,
          participatesInRootNavigator: true,
        ),
        GetPage<Routes>(
          name: Routes.signup.name,
          page: () => const SignupScreen(),
          binding: SignupScreenBinding(),
          maintainState: false,
          popGesture: false,
          preventDuplicates: true,
          fullscreenDialog: true,
          transition: Transition.fade,
          alignment: Alignment.center,
          participatesInRootNavigator: true,
          middlewares: [
            AuthMiddleware()
          ]
        ),
      ];
}
