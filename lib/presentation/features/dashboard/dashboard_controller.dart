import 'package:get/get.dart';
import 'package:suhol_van_sales/presentation/utils/service_one.dart';

class DashboardController extends GetxController {
  var todayCashSales = 128.00.obs;

  var previousDayCashSale = "3,891".obs;

  var previousDayCashOrder = "151".obs;

  RxList<Map<String, String>> ads = RxList.of([
    {"SALE OFF 20%": "https://rohit7823.github.io/assets/ad_one.png"},
    {"GIVE COUPONS": "https://rohit7823.github.io/assets/ad_two.png"}
  ]);

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

  void onTapServiceOne(ServiceOne service) {}
}
