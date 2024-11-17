
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:suhol_van_sales/domain/data_source/remote/material_request/response/create_material_requisition.dart';

import '../request/material_requisition_request.dart';
import '../response/last_material_orders_response.dart';

part 'material_request_api.g.dart';

@RestApi()
abstract class MaterialRequestApi {
  factory MaterialRequestApi(Dio dio, {String? baseUrl}) = _MaterialRequestApi;

  @POST("/material-requests/create-material-requisition")
  Future<CreateMaterialRequisitionResponse> createRequisition(
      @Body() MaterialRequisitionRequest request);

  @POST("/material-requests/create-requisition-order")
  Future<CreateMaterialRequisitionResponse> createRequisitionOrder(
      @Body() MaterialRequisitionRequest request);

  @GET('/material-requests/last-five-order-pickups')
  Future<LastMaterialOrdersResponse> lastMaterialOrdersPickups(
      @Query('customer_id') String customerId);
}
