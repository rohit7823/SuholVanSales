import 'package:get/get.dart';

import 'create_cash_order_screen_controller.dart';

class CreateCashOrderScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateCashOrderScreenController());
  }
}
