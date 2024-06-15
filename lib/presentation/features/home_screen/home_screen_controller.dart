import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/presentation/navigation/home_graph.dart';
import 'package:suhol_van_sales/presentation/utils/bottom_menus.dart';

class HomeScreenController extends GetxController {
  var userName = "Marcel".obs;

  var shopName = "Shop 01".obs;

  Rx<BottomMenus> selectedBottomMenu = BottomMenus.home.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void onSelectBottomMenu(int value) {
    selectedBottomMenu.value = BottomMenus.values.firstWhere(
      (element) => element.index == value,
      orElse: () => BottomMenus.home,
    );
  }

  bool onChildPop(Route route, result) {
    debugPrint("route ${route.settings.name}");
    return true;
  }

  void backPress(bool didPop) {
    var navState = Get.nestedKey(HomeGraph.instance.navKey)?.currentState;

    if (navState?.canPop() == true) {
      navState?.pop();
    } else {
      Get.back();
    }
  }
}
