import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/app/theme/colors.dart';
import 'package:suhol_van_sales/presentation/navigation/home_graph.dart';
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
      backgroundColor: Get.theme.colorScheme.primary,
      appBar: MyAppBar(
        leading: const Icon(
          Icons.menu_rounded,
          color: Colors.black,
        ),
        leadingWidth: Get.width * .15,
        title: UserInfo(
            userName: controller.userName, shopName: controller.shopName),
      ),
      body: GetNavigator(
        key: Get.nestedKey(HomeGraph.instance.navKey),
        pages: HomeGraph.instance.pages(),

      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            elevation: 7,
            onTap: controller.onSelectBottomMenu,
            currentIndex: controller.selectedBottomMenu.value.index,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            type: BottomNavigationBarType.shifting,
            selectedItemColor: AppColors.bottomMenuLabelColor,
            unselectedItemColor: Colors.grey.shade400,
            items: BottomMenus.values
                .map(
                  (menu) => BottomNavigationBarItem(
                      icon: Image.asset(
                        menu.image,
                        color: Colors.grey.shade400,
                      ),
                      label: menu.name,
                      tooltip: menu.name,
                      activeIcon: Image.asset(
                        menu.image,
                        color: AppColors.bottomMenuLabelColor,
                      )
                  ),
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
