import 'package:get/get.dart';
import 'package:suhol_van_sales/domain/data_source/local/customers/database/entities/customer_db.dart';
import 'package:suhol_van_sales/domain/data_source/local/customers/database/entities/location_db.dart';
import 'package:suhol_van_sales/domain/data_source/local/products/entities/packing_db.dart';
import 'package:suhol_van_sales/domain/data_source/local/products/entities/packing_pivot.dart';
import 'package:suhol_van_sales/domain/data_source/local/products/entities/product_db.dart';
import 'package:suhol_van_sales/domain/data_source/local/products/entities/unit_element_db.dart';
import 'package:suhol_van_sales/domain/data_source/local/products/entities/unit_pivot_db.dart';
import 'package:suhol_van_sales/domain/data_source/local/user_onboarding/entities/user_onboarding.dart';
import 'package:suhol_van_sales/domain/models/customer.dart';
import 'package:suhol_van_sales/domain/models/product.dart';
import 'package:suhol_van_sales/domain/models/user_onboarding.dart';

extension OnboardingDataLayerExts on UserOnboarding {
  UserOnboardingDB get toDb {
    return UserOnboardingDB(
        email: email, name: name, password: password, type: type);
  }

  bool get isGenuine => !((email == null && password == null) ||
      (email?.isEmail == false && password?.isBlank == true));
}

extension CustomerDataLayerExts on Customer {
  CustomerDB get toDB => CustomerDB(
      status: status,
      address: address,
      contactPerson: contactPerson,
      customerCode: customerCode,
      email: email,
      id: id,
      location: location,
      mobileNumber: mobileNumber,
      name: name,
      productLastUpdate: productLastUpdate)
    ..locations.addAll(locations
            ?.map(
              (e) => e.toDB,
            )
            .toList() ??
        <LocationDB>[]);
}

extension LocationDataLayerExts on Location {
  LocationDB get toDB => LocationDB(
      vatIdentificationNumbers: vatIdentificationNumbers,
      location: location,
      productLastUpdate: productLastUpdate,
      id: id,
      addressOne: addressOne,
      addressTwo: addressTwo,
      companyName: companyName,
      phoneNo: phoneNo,
      productLink: productLink,
      taxPercentage: taxPercentage);
}

extension ProductDataLayerExts on Product {
  ProductDB get toDB {
    var product = ProductDB(
        name: name,
        alias: alias,
        code: code,
        id: id,
        remarks: remarks,
        secondaryName: secondaryName,
        tax: tax);
    product.packings.addAll(packings
            ?.map(
              (p) => p.toDB,
            )
            .toList() ??
        []);
    product.units.addAll(units
            ?.map(
              (u) => u.toDB,
            )
            .toList() ??
        []);
    return product;
  }
}

extension PackingDataLayerExts on Packing {
  PackingDB get toDB => PackingDB(
      id: id,
      createdAt: createdAt,
      deletedAt: deletedAt,
      isActive: isActive,
      packing: packing,
      updatedAt: updatedAt,
      pivot: pivot?.toDB);
}

extension PivotDataLayerExts on PackingPivot {
  PackingPivotDB get toDB =>
      PackingPivotDB(packingId: packingId, productId: productId);
}

extension UnitElementDataLayerExts on UnitElement {
  UnitElementDB get toDB => UnitElementDB(
      updatedAt: updatedAt,
      isActive: isActive,
      deletedAt: deletedAt,
      createdAt: createdAt,
      id: id,
      name: name,
      unit: unit,
      unitCode: unitCode,
      pivot: pivot?.toDB);
}

extension UnitPivotDataLayerExts on UnitPivot {
  UnitPivotDB get toDB => UnitPivotDB(
      productId: productId, unitOfMeasurementId: unitOfMeasurementId);
}
