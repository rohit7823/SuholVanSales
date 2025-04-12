// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_requisition_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$MaterialRequisitionRequestToJson(
        MaterialRequisitionRequest instance) =>
    <String, dynamic>{
      'customer_id': instance.customerId,
      'delivery_date': instance.deliveryDate?.toIso8601String(),
      'delivery_time': instance.deliveryTime,
      'vehicle_no': instance.vehicleNo,
      'product_id': instance.productId,
      'unit_of_measurement_id': instance.unitOfMeasurementId,
      'packing_id': instance.packingId,
      'remarks': instance.remarks,
      'parent_master_id_list': instance.locationIdsWithQuantity,
    };

LocationIDWithQuantity _$LocationIDWithQuantityFromJson(
        Map<String, dynamic> json) =>
    LocationIDWithQuantity(
      id: (json['id'] as num?)?.toInt(),
      qty: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LocationIDWithQuantityToJson(
        LocationIDWithQuantity instance) =>
    <String, dynamic>{
      'id': instance.id ?? 0,
      'quantity': instance.qty ?? 0,
    };
