import 'package:flutter/material.dart';
import 'package:suhol_van_sales/domain/data_source/remote/material_request/request/material_requisition_request.dart';

class AddedProductUiModel {
  final String? productName;
  final String? packing;
  final String? unit;
  final int? quantity;
  final DateTime? deliveryDate;
  final TimeOfDay? deliveryTime;
  final double? price;
  final MaterialRequisitionRequest? allDetails;

  const AddedProductUiModel({
    this.productName,
    this.packing,
    this.unit,
    this.quantity,
    this.deliveryDate,
    this.deliveryTime,
    this.price,
    this.allDetails,
  });

  AddedProductUiModel copyWith(
      {String? productName,
      String? packing,
      String? unit,
      int? quantity,
      DateTime? deliveryDate,
      TimeOfDay? deliveryTime,
      double? price,
      MaterialRequisitionRequest? allDetails}) {
    return AddedProductUiModel(
        productName: productName ?? this.productName,
        packing: packing ?? this.packing,
        unit: unit ?? this.unit,
        quantity: quantity ?? this.quantity,
        deliveryDate: deliveryDate ?? this.deliveryDate,
        deliveryTime: deliveryTime ?? this.deliveryTime,
        price: price ?? this.price,
        allDetails: allDetails ?? this.allDetails);
  }
}
