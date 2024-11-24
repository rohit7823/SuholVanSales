import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'material_requisition_request.g.dart';

@JsonSerializable()
class MaterialRequisitionRequest {
  @JsonKey(name: "customer_id")
  final int? customerId;
  @JsonKey(name: "division_id")
  final int? divisionId;
  @JsonKey(name: "delivery_date")
  final DateTime? deliveryDate;
  @JsonKey(name: "delivery_time")
  final TimeOfDay? deliveryTime;
  @JsonKey(name: "vehicle_no")
  final String? vehicleNo;
  @JsonKey(name: "product_id")
  final int? productId;
  @JsonKey(name: "unit_of_measurement_id")
  final int? unitOfMeasurementId;
  @JsonKey(name: "packing_id")
  final int? packingId;
  @JsonKey(name: "remarks")
  final String? remarks;
  @JsonKey(name: "parent_master_id_list")
  final List<LocationIDWithQuantity>? locationIdsWithQuantity;
  @JsonKey(name: 'qty')
  final int? quantity;

  const MaterialRequisitionRequest(
      {this.customerId,
      this.divisionId,
      this.deliveryDate,
      this.deliveryTime,
      this.vehicleNo,
      this.productId,
      this.unitOfMeasurementId,
      this.packingId,
      this.remarks,
      this.locationIdsWithQuantity,
      this.quantity});

  MaterialRequisitionRequest copyWith(
      {int? customerId,
      int? divisionId,
      DateTime? deliveryDate,
      TimeOfDay? deliveryTime,
      String? vehicleNo,
      int? productId,
      int? unitOfMeasurementId,
      int? packingId,
      String? remarks,
      List<LocationIDWithQuantity>? locationIdsWithQuantity,
      int? quantity}) {
    return MaterialRequisitionRequest(
        customerId: customerId ?? this.customerId,
        divisionId: divisionId ?? this.divisionId,
        deliveryDate: deliveryDate ?? this.deliveryDate,
        vehicleNo: vehicleNo ?? this.vehicleNo,
        productId: productId ?? this.productId,
        unitOfMeasurementId: unitOfMeasurementId ?? this.unitOfMeasurementId,
        packingId: packingId ?? this.packingId,
        remarks: remarks ?? this.remarks,
        locationIdsWithQuantity:
            locationIdsWithQuantity ?? this.locationIdsWithQuantity,
        deliveryTime: deliveryTime ?? this.deliveryTime,
        quantity: quantity ?? this.quantity);
  }

  factory MaterialRequisitionRequest.fromJson(Map<String, dynamic> json) =>
      MaterialRequisitionRequest(
          customerId: (json['customer_id'] as num?)?.toInt(),
          divisionId: (json['division_id'] as num?)?.toInt(),
          deliveryDate: json['delivery_date'] == null
              ? null
              : DateTime.parse(json['delivery_date'] as String),
          vehicleNo: json['vehicle_no'] as String?,
          productId: (json['product_id'] as num?)?.toInt(),
          unitOfMeasurementId:
              (json['unit_of_measurement_id'] as num?)?.toInt(),
          packingId: (json['packing_id'] as num?)?.toInt(),
          remarks: json['remarks'] as String?,
          locationIdsWithQuantity: (json['parent_master_id_list']
                  as List<dynamic>?)
              ?.map((e) =>
                  LocationIDWithQuantity.fromJson(e as Map<String, dynamic>))
              .toList(),
          quantity: json['qty'] as int?);

  Map<String, dynamic> toJson() {
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final date = deliveryDate ?? DateTime.now();
    final time = deliveryTime ?? TimeOfDay.now();
    final withDate =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);

    return <String, dynamic>{
      'customer_id': customerId,
      'division_id': divisionId,
      'delivery_date': formatter.format(withDate),
      'vehicle_no': vehicleNo,
      'product_id': productId,
      'unit_of_measurement_id': unitOfMeasurementId,
      'packing_id': packingId,
      'remarks': remarks,
      'parent_master_id_list': locationIdsWithQuantity
          ?.map(
            (e) => e.toJson(),
          )
          .toList(),
      'delivery_time': deliveryTime == null
          ? null
          : "${deliveryTime?.hour}${deliveryTime?.minute}",
      'products': [
        {
          'product_id': productId,
          'unit_of_measurement_id': unitOfMeasurementId,
          'packing_id': packingId,
          'quantity': quantity
        }
      ],
      'qty': quantity
    };
  }

  bool get isValid =>
      customerId != null &&
      deliveryDate != null &&
      deliveryTime != null &&
      vehicleNo != null &&
      productId != null &&
      unitOfMeasurementId != null &&
      packingId != null &&
      remarks != null &&
      locationIdsWithQuantity?.isEmpty == true;
}

@JsonSerializable()
class LocationIDWithQuantity {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "quantity")
  final int? qty;

  const LocationIDWithQuantity({
    this.id,
    this.qty,
  });

  factory LocationIDWithQuantity.fromJson(Map<String, dynamic> json) =>
      _$LocationIDWithQuantityFromJson(json);

  Map<String, dynamic> toJson() => _$LocationIDWithQuantityToJson(this);
}
