import 'package:get/get.dart';
import 'package:suhol_van_sales/presentation/features/create_preorder_screen/create_preorder_screen_controller.dart';

class CreatePreorderScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreatePreorderScreenController());
  }
}
