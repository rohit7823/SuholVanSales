import 'package:get/get.dart';
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
}
