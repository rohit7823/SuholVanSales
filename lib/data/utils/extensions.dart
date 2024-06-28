import 'package:suhol_van_sales/domain/data_source/local/customers/database/entities/customer_db.dart';
import 'package:suhol_van_sales/domain/data_source/local/customers/database/entities/location_db.dart';
import 'package:suhol_van_sales/domain/data_source/local/user_onboarding/entities/user_onboarding.dart';
import 'package:suhol_van_sales/domain/models/customer_details.dart';
import 'package:suhol_van_sales/domain/models/user_onboarding.dart';

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
