import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/domain/models/customer.dart';

class LocationWithQuantityUiModel {
  final Location? location;
  final TextEditingController qty = TextEditingController(text: "1");

  LocationWithQuantityUiModel({
    this.location,
  });

  LocationWithQuantityUiModel copyWith({
    Location? location,
  }) {
    return LocationWithQuantityUiModel(
      location: location ?? this.location,
    );
  }

  bool get isValid => location?.id != null && qty.text.isBlank == true;
}
