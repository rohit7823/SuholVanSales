import 'package:get/get.dart';
import 'package:suhol_van_sales/domain/data_source/remote/approved_orders/response/approved_orders_response.dart';
import 'package:suhol_van_sales/domain/data_source/remote/web_service_pool.dart';
import 'package:suhol_van_sales/domain/di/session_service.dart';
import 'package:suhol_van_sales/domain/utils/response.dart';
import 'package:suhol_van_sales/presentation/features/approved_orders/approved_orders_logic.dart';

class ApprovedOrdersRepositoryImpl with WebServicePool {
  final _session = Get.find<SessionService>();

  Future<RestResponse<ApprovedOrdersResponse>> cashApprovedOrders() async {
    return await approvedOrders(
        _session.appToken ?? '', OrderType.cashSalesOrder);
  }

  Future<RestResponse<ApprovedOrdersResponse>> creditApprovedOrders() async {
    return await approvedOrders(
        _session.appToken ?? '', OrderType.creditSalesOrder);
  }
}
