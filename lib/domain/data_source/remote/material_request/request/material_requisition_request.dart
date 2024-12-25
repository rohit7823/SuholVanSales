import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:suhol_van_sales/presentation/utils/extensions.dart';

part 'material_requisition_request.g.dart';

@JsonSerializable()
class MaterialRequisitionRequest {
  final String? customerName;
  final int? phoneNo;
  final String? productName;
  final String? productUnit;
  final String? productPacking;
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
  @JsonKey(name: "price")
  final double? price;
  @JsonKey(name: "remarks")
  final String? remarks;
  @JsonKey(name: "parent_master_id_list")
  final List<LocationIDWithQuantity>? locationIdsWithQuantity;
  @JsonKey(name: 'qty')
  final int? quantity;

  const MaterialRequisitionRequest(
      {this.customerName,
      this.phoneNo,
      this.productName,
      this.productPacking,
      this.productUnit,
      this.customerId,
      this.divisionId,
      this.deliveryDate,
      this.deliveryTime,
      this.vehicleNo,
      this.productId,
      this.unitOfMeasurementId,
      this.packingId,
      this.price,
      this.remarks,
      this.locationIdsWithQuantity,
      this.quantity});

  MaterialRequisitionRequest copyWith(
      {String? customerName,
      int? phoneNo,
      String? productName,
      String? productUnit,
      String? productPacking,
      int? customerId,
      int? divisionId,
      DateTime? deliveryDate,
      TimeOfDay? deliveryTime,
      String? vehicleNo,
      int? productId,
      int? unitOfMeasurementId,
      int? packingId,
      double? price,
      String? remarks,
      List<LocationIDWithQuantity>? locationIdsWithQuantity,
      int? quantity}) {
    return MaterialRequisitionRequest(
        customerName: customerName ?? this.customerName,
        phoneNo: phoneNo ?? this.phoneNo,
        productName: productName ?? this.productName,
        productPacking: productPacking ?? this.productPacking,
        productUnit: productUnit ?? this.productUnit,
        customerId: customerId ?? this.customerId,
        divisionId: divisionId ?? this.divisionId,
        deliveryDate: deliveryDate ?? this.deliveryDate,
        vehicleNo: vehicleNo ?? this.vehicleNo,
        productId: productId ?? this.productId,
        unitOfMeasurementId: unitOfMeasurementId ?? this.unitOfMeasurementId,
        packingId: packingId ?? this.packingId,
        price: price ?? this.price,
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
          price: double.tryParse(json['price'] as String? ?? '0.00'),
          remarks: json['remarks'] as String?,
          locationIdsWithQuantity: (json['parent_master_id_list']
                  as List<dynamic>?)
              ?.map((e) =>
                  LocationIDWithQuantity.fromJson(e as Map<String, dynamic>))
              .toList(),
          quantity: json['qty'] as int?);

  Map<String, dynamic> toJson() {
    final date = deliveryDate ?? DateTime.now();
    final time = deliveryTime ?? TimeOfDay.now();
    return <String, dynamic>{
      'customer_id': customerId,
      'division_id': divisionId,
      'delivery_date': date.formattedDateWithTime(time),
      'vehicle_no': vehicleNo,
      'product_id': productId,
      'unit_of_measurement_id': unitOfMeasurementId,
      'packing_id': packingId,
      'price': price,
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
