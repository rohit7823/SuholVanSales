import 'package:get/get.dart';
import 'package:suhol_van_sales/presentation/features/create_mr_order_screen/create_mr_order_screen_controller.dart';

class CreateMrOrderScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateMrOrderScreenController());
  }
}
