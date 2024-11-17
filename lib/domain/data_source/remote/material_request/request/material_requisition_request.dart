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
  final String? deliveryTime;
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
      this.locationIdsWithQuantity});

  MaterialRequisitionRequest copyWith(
      {int? customerId,
      int? divisionId,
      DateTime? deliveryDate,
      String? deliveryTime,
      String? vehicleNo,
      int? productId,
      int? unitOfMeasurementId,
      int? packingId,
      String? remarks,
      List<LocationIDWithQuantity>? locationIdsWithQuantity}) {
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
        deliveryTime: deliveryTime ?? this.deliveryTime);
  }

  factory MaterialRequisitionRequest.fromJson(Map<String, dynamic> json) =>
      _$MaterialRequisitionRequestFromJson(json);

  Map<String, dynamic> toJson() {
    final formatter = DateFormat('yyyy-MM-dd');
    return <String, dynamic>{
      'customer_id': customerId,
      'division_id': divisionId,
      'delivery_date': formatter.format(deliveryDate ?? DateTime.now()),
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
      'delivery_time': deliveryTime
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
