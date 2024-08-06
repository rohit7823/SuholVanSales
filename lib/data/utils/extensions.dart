import 'package:suhol_van_sales/domain/data_source/local/customers/database/entities/customer_db.dart';
import 'package:suhol_van_sales/domain/data_source/local/customers/database/entities/location_db.dart';
import 'package:suhol_van_sales/domain/data_source/local/products/entities/product_db.dart';
import 'package:suhol_van_sales/domain/data_source/local/user_onboarding/entities/user_onboarding.dart';
import 'package:suhol_van_sales/domain/models/customer.dart';
import 'package:suhol_van_sales/domain/models/user_onboarding.dart';

import '../../domain/data_source/local/products/entities/packing_db.dart';
import '../../domain/data_source/local/products/entities/packing_pivot.dart';
import '../../domain/data_source/local/products/entities/unit_element_db.dart';
import '../../domain/data_source/local/products/entities/unit_pivot_db.dart';
import '../../domain/models/product.dart';

extension OnboardingDbLayerExts on UserOnboardingDB {
  UserOnboarding get toData =>
      UserOnboarding(type: type, password: password, name: name, email: email);
}

extension CustomerDbExts on CustomerDB {
  Customer get toData => Customer(
      status: status,
      address: address,
      contactPerson: contactPerson,
      customerCode: customerCode,
      email: email,
      id: id,
      location: location,
      mobileNumber: mobileNumber,
      name: name,
      productLastUpdate: productLastUpdate);
}

extension LocationDbExts on LocationDB {
  Location get toData => Location(
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

extension ProductDbLayerExts on ProductDB {
  Product get toData {
    var product = Product(
        name: name,
        alias: alias,
        code: code,
        id: id,
        remarks: remarks,
        secondaryName: secondaryName,
        tax: tax,
        packings: packings
            .map(
              (element) => element.toData,
            )
            .toList(),
        units: units
            .map(
              (element) => element.toData,
            )
            .toList());

    return product;
  }
}

extension PackingDbLayerExts on PackingDB {
  Packing get toData => Packing(
        id: id,
        createdAt: createdAt,
        deletedAt: deletedAt,
        isActive: isActive,
        packing: packing,
        updatedAt: updatedAt,
        pivot: pivot?.toData,
      );
}

extension PivotDbLayerExts on PackingPivotDB {
  PackingPivot get toData =>
      PackingPivot(packingId: packingId, productId: productId);
}

extension UnitElementDbLayerExts on UnitElementDB {
  UnitElement get toData => UnitElement(
      updatedAt: updatedAt,
      isActive: isActive,
      deletedAt: deletedAt,
      createdAt: createdAt,
      id: id,
      name: name,
      unit: unit,
      unitCode: unitCode,
      pivot: pivot?.toData);
}

extension UnitPivotDbLayerExts on UnitPivotDB {
  UnitPivot get toData =>
      UnitPivot(productId: productId, unitOfMeasurementId: unitOfMeasurementId);
}
