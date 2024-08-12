// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_requisition_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialRequisitionRequest _$MaterialRequisitionRequestFromJson(
        Map<String, dynamic> json) =>
    MaterialRequisitionRequest(
      customerId: (json['customer_id'] as num?)?.toInt(),
      deliveryDate: json['delivery_date'] == null
          ? null
          : DateTime.parse(json['delivery_date'] as String),
      vehicleNo: json['vehicle_no'] as String?,
      productId: (json['product_id'] as num?)?.toInt(),
      unitOfMeasurementId: (json['unit_of_measurement_id'] as num?)?.toInt(),
      packingId: (json['packing_id'] as num?)?.toInt(),
      remarks: json['remarks'] as String?,
      locationIdsWithQuantity: (json['parent_master_id_list'] as List<dynamic>?)
          ?.map(
              (e) => LocationIDWithQuantity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MaterialRequisitionRequestToJson(
        MaterialRequisitionRequest instance) =>
    <String, dynamic>{
      'customer_id': instance.customerId,
      'delivery_date': instance.deliveryDate?.toIso8601String(),
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
      'id': instance.id,
      'quantity': instance.qty,
    };
