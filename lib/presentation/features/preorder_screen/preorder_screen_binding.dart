import 'package:get/get.dart';
import 'package:suhol_van_sales/presentation/features/preorder_screen/preorder_screen_controller.dart';

class PreorderScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PreorderScreenController());
  }
}
