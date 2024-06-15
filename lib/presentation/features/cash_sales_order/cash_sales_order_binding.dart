import 'package:get/get.dart';

import 'cash_sales_order_controller.dart';

class CashSalesOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CashSalesOrderController());
  }
}
