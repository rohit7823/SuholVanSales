import 'package:get/get.dart';

import 'credit_sales_order_controller.dart';

class CreditSalesOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreditSalesOrderController());
  }
}
