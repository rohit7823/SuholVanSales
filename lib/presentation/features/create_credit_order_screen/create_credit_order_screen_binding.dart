import 'package:get/get.dart';
import 'package:suhol_van_sales/data/repo_impls/create_credit_order_repository_impl.dart';
import 'package:suhol_van_sales/presentation/features/create_credit_order_screen/create_credit_order_repository.dart';

import 'create_credit_order_screen_controller.dart';

class CreateCreditOrderScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateCreditOrderRepository>(
        () => CreateCreditOrderRepositoryImpl());
    Get.lazyPut(() => CreateCreditOrderScreenController());
  }
}
