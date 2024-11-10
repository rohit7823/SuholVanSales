import 'package:get/get.dart';
import 'package:suhol_van_sales/presentation/features/mr_order_screen/mr_order_screen_controller.dart';

class MrOrderScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MrOrderScreenController());
  }
}
