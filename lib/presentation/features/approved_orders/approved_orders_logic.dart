import 'package:get/get.dart';
import 'package:suhol_van_sales/data/repo_impls/approved_orders_repository.dart';
import 'package:suhol_van_sales/domain/data_source/remote/approved_orders/response/approved_orders_response.dart';
import 'package:suhol_van_sales/domain/utils/response.dart';
import 'package:suhol_van_sales/presentation/widgets/animated_progress.dart';

import '../../../data/repo_impls/create_cash_order_repository_impl.dart';

enum OrderType {
  cashSalesOrder,
  creditSalesOrder,
}

class ApprovedOrdersController extends GetxController {
  Rx<OrderType> orderType = OrderType.cashSalesOrder.obs;
  final _repo = Get.find<ApprovedOrdersRepositoryImpl>();
  RxList<Order> cashSales = RxList.empty();
  RxList<Order> creditSales = RxList.empty();

  var userName = ''.obs;
  var shopName = ''.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    orderType.value = Get.arguments ?? OrderType.cashSalesOrder;
    if (orderType.value == OrderType.cashSalesOrder) {
      approvedOrdersCash();
    } else {
      approvedOrdersCredit();
    }
  }

  Future<void> approvedOrdersCash() async {
    AnimatedProgress.showProgressIfNot();
    final response = await _repo.cashApprovedOrders();
    AnimatedProgress.closeProgressIfShowing();
    if (response is Success) {
      switch (response.data?.success) {
        case true:
          cashSales.value = response.data?.data ?? [];
          break;
        case false:
          break;
        case null:
          break;
      }
    } else if (response is Error) {}
  }

  Future<void> approvedOrdersCredit() async {
    AnimatedProgress.showProgressIfNot();
    final response = await _repo.creditApprovedOrders();
    AnimatedProgress.closeProgressIfShowing();
    if (response is Success) {
      switch (response.data?.success) {
        case true:
          creditSales.value = response.data?.data ?? [];
          break;
        case false:
          break;
        case null:
          break;
      }
    } else if (response is Error) {}
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    Get.delete<CreateCashOrderRepositoryImpl>();
  }

  void pop() {
    Get.back();
  }
}
