import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/app/theme/colors.dart';
import 'package:suhol_van_sales/app/theme/images.dart';
import 'package:suhol_van_sales/presentation/utils/bottom_menus.dart';
import 'package:suhol_van_sales/presentation/widgets/my_app_bar.dart';
import 'package:suhol_van_sales/presentation/widgets/user_info.dart';

import 'home_screen_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        leading: Image.asset(Images.menu),
        title: UserInfo(
            userName: controller.userName, shopName: controller.shopName),
      ),
      body: SafeArea(
          child: Column(
        children: [],
      )),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            elevation: 6,
            onTap: controller.onSelectBottomMenu,
            currentIndex: controller.selectedBottomMenu.value.index,
            type: BottomNavigationBarType.shifting,
            selectedItemColor: AppColors.primary,
            showSelectedLabels: true,
            selectedLabelStyle: Get
                .theme.bottomNavigationBarTheme.selectedLabelStyle!
                .copyWith(color: AppColors.bottomMenuLabelColor),
            unselectedLabelStyle:
                Get.theme.bottomNavigationBarTheme.selectedLabelStyle,
            selectedIconTheme: const IconThemeData(
              color: AppColors.bottomMenuLabelColor,
            ),
            unselectedIconTheme: IconThemeData(
              color: Colors.grey.shade400,
            ),
            items: BottomMenus.values
                .map(
                  (menu) => BottomNavigationBarItem(
                      icon: Image.asset(menu.image),
                      label: menu.name,
                      activeIcon: Image.asset(
                        menu.image,
                      )),
                )
                .toList()),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<HomeScreenController>();
    super.dispose();
  }
}
