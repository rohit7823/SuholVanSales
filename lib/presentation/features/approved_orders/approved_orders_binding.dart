import 'package:get/get.dart';
import 'package:suhol_van_sales/data/repo_impls/approved_orders_repository.dart';

import 'approved_orders_logic.dart';

class ApprovedOrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApprovedOrdersRepositoryImpl(),);
    Get.lazyPut(() => ApprovedOrdersController());
  }
}
