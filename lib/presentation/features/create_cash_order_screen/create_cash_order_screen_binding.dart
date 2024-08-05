import 'package:get/get.dart';
import 'package:suhol_van_sales/data/repo_impls/create_cash_order_repository_impl.dart';
import 'package:suhol_van_sales/presentation/features/create_cash_order_screen/create_cash_order_repository.dart';

import 'create_cash_order_screen_controller.dart';

class CreateCashOrderScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateCashOrderRepository>(
      () => CreateCashOrderRepositoryImpl()
    );
    Get.lazyPut(() => CreateCashOrderScreenController());
  }
}
