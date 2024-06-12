import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/presentation/features/dashboard/dashboard_binding.dart';
import 'package:suhol_van_sales/presentation/features/dashboard/dashboard_screen.dart';
import 'package:suhol_van_sales/presentation/features/home_screen/home_screen_view.dart';

import 'routes.dart';

class HomeGraph {
  HomeGraph._();

  static HomeGraph instance = HomeGraph._();

  int navKey = 1705;

  List<GetPage<Routes>> pages() => [
    GetPage<Routes>(
        name: Routes.dashboard.name,
        page: () => const DashboardScreen(),
        binding: DashboardBinding(),
        maintainState: true,
        popGesture: true,
        preventDuplicates: true,
        transition: Transition.native,
        curve: Curves.slowMiddle
    )
  ];

}