import 'package:get/get.dart';
import 'package:suhol_van_sales/domain/data_source/local/customers/database/entities/customer_db.dart';
import 'package:suhol_van_sales/domain/data_source/local/customers/database/entities/location_db.dart';
import 'package:suhol_van_sales/domain/data_source/local/user_onboarding/entities/user_onboarding.dart';
import 'package:suhol_van_sales/domain/models/customer_details.dart';
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
      productLastUpdate: productLastUpdate);
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
