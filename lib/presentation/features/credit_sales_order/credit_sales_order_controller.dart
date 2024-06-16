import 'package:get/get.dart';
import 'package:suhol_van_sales/presentation/navigation/home_graph.dart';
import 'package:suhol_van_sales/presentation/navigation/routes.dart';
import 'package:suhol_van_sales/presentation/utils/credit_order_history_types.dart';

class CreditSalesOrderController extends GetxController {
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

  void onTapCreditHistory(CreditOrderHistoryTypes type) {
    switch (type) {
      case CreditOrderHistoryTypes.creditSalesOrder:
        Get.toNamed(Routes.createCreditOrder.name);
      case CreditOrderHistoryTypes.creditSalesOrderList:
      // TODO: Handle this case.
      case CreditOrderHistoryTypes.creditApprovedOrder:
      // TODO: Handle this case.
      case CreditOrderHistoryTypes.creditSalesReturn:
      // TODO: Handle this case.
      case CreditOrderHistoryTypes.customerMiniStatement:
      // TODO: Handle this case.
      case CreditOrderHistoryTypes.billToBilCash:
      // TODO: Handle this case.
    }
  }
}
