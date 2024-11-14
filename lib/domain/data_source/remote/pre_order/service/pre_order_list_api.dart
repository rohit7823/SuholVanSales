
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:suhol_van_sales/domain/data_source/remote/pre_order/response/pre_orders_response.dart';

part 'pre_order_list_api.g.dart';

@RestApi()
abstract class PreOrderListApi {
  factory PreOrderListApi(Dio dio, {String? baseUrl}) = _PreOrderListApi;

  @GET("/material-requests/pre-order-list")
  Future<PreOrdersResponse> preOrderLists();
}
