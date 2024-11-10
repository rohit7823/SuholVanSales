import 'package:get/get.dart';
import 'package:suhol_van_sales/domain/di/session_service.dart';
import 'package:suhol_van_sales/presentation/navigation/home_graph.dart';
import 'package:suhol_van_sales/presentation/navigation/routes.dart';
import 'package:suhol_van_sales/presentation/utils/mrorder_types.dart';

class MrOrderScreenController extends GetxController {
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

  void pop() {
    HomeGraph.instance.pop();
  }

  void onTapMROrder(MrOrderTypes type) {
    switch (type) {
      case MrOrderTypes.mrCreate:
        Get.toNamed(Routes.createMrorder.name);
      case MrOrderTypes.mrOrders:
      // TODO: Handle this case.
      case MrOrderTypes.mrApproved:
      // TODO: Handle this case.
    }
  }
}
