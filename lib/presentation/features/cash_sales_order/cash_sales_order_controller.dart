import 'package:get/get.dart';
import 'package:suhol_van_sales/presentation/navigation/home_graph.dart';
import 'package:suhol_van_sales/presentation/navigation/routes.dart';
import 'package:suhol_van_sales/presentation/utils/cash_order_history_types.dart';

class CashSalesOrderController extends GetxController {
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void pop() {
    HomeGraph.instance.pop();
  }

  void onTapCashHistory(CashOrderHistoryTypes type) {
    switch (type) {
      case CashOrderHistoryTypes.cashSalesOrder:
        Get.toNamed(Routes.createCashOrder.name);
      case CashOrderHistoryTypes.cashSalesOrderList:
      // TODO: Handle this case.
      case CashOrderHistoryTypes.cashApprovedOrder:
      // TODO: Handle this case.
    }
  }
}
