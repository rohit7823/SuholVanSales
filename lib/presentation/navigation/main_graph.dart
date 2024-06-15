import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/presentation/features/home_screen/home_screen_binding.dart';
import 'package:suhol_van_sales/presentation/features/home_screen/home_screen_view.dart';
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
          popGesture: true,
          preventDuplicates: true,
          transition: Transition.leftToRightWithFade,
          curve: Curves.slowMiddle,
        )
      ];
}
