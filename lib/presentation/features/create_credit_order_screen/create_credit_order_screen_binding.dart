import 'package:get/get.dart';

import 'create_credit_order_screen_controller.dart';

class CreateCreditOrderScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateCreditOrderScreenController());
  }
}
