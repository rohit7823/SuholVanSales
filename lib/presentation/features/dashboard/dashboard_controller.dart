import 'package:get/get.dart';
import 'package:suhol_van_sales/domain/di/session_service.dart';
import 'package:suhol_van_sales/presentation/navigation/home_graph.dart';
import 'package:suhol_van_sales/presentation/navigation/routes.dart';
import 'package:suhol_van_sales/presentation/utils/service_one.dart';

class DashboardController extends GetxController {
  var todayCashSales = 128.00.obs;

  var previousDayCashSale = "3,891".obs;

  var previousDayCashOrder = "151".obs;

  RxList<Map<String, String>> ads = RxList.of([
    {"SALE OFF 20%": "https://rohit7823.github.io/assets/ad_one.png"},
    {"GIVE COUPONS": "https://rohit7823.github.io/assets/ad_two.png"}
  ]);

  final session = Get.find<SessionService>();

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

  void onTapServiceOne(ServiceOne service) {
    switch (service) {
      case ServiceOne.cashSales:
        Get.toNamed(Routes.cashSalesOrder.name, id: HomeGraph.instance.navKey);
        break;
      case ServiceOne.creditSales:
        Get.toNamed(Routes.creditSalesOrder.name,
            id: HomeGraph.instance.navKey);
        break;
      case ServiceOne.preOrder:
        Get.toNamed(Routes.preorder.name, id: HomeGraph.instance.navKey);
        break;
      case ServiceOne.remotePrint:
      // TODO: Handle this case.
      case ServiceOne.stocks:
      // TODO: Handle this case.
      case ServiceOne.collection:
      // TODO: Handle this case.
      case ServiceOne.purchaseOrder:
      // TODO: Handle this case.
      case ServiceOne.myOrder:
        Get.toNamed(Routes.mrorder.name, id: HomeGraph.instance.navKey);
        break;
      case ServiceOne.allService:
      // TODO: Handle this case.
    }
  }
}
