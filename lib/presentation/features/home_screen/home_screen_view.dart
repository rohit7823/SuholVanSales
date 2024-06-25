import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/app/theme/colors.dart';
import 'package:suhol_van_sales/presentation/navigation/home_graph.dart';
import 'package:suhol_van_sales/presentation/navigation/routes.dart';
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
        actions: [
          Obx(() => !controller.isLoggedIn.value
              ? Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: IconButton(
                      onPressed: controller.login,
                      icon: const Icon(
                        Icons.login,
                        color: AppColors.buttonColorAlternate,
                        size: 40,
                      )),
                )
              : const SizedBox.shrink())
        ],
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: controller.backPress,
        child: Navigator(
          requestFocus: true,
          key: Get.nestedKey(HomeGraph.instance.navKey),
          initialRoute: Routes.dashboard.name,
          onGenerateRoute: HomeGraph.instance.routes,
          onPopPage: controller.onChildPop,
          reportsRouteUpdateToEngine: true,
        ),
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
                      icon: Icon(
                        menu.icon,
                        color: Colors.grey.shade400,
                      ),
                      label: menu.name,
                      tooltip: menu.name,
                      activeIcon: Icon(
                        menu.icon,
                        color: AppColors.bottomMenuLabelColor,
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
