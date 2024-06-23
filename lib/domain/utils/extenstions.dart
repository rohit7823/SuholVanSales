import 'package:get/get.dart';
import 'package:suhol_van_sales/domain/data_source/local/user_onboarding/entities/user_onboarding.dart';
import 'package:suhol_van_sales/domain/models/user_onboarding.dart';

extension OnboardingDataLayerExts on UserOnboarding {
  UserOnboardingDB get toDb {
    return UserOnboardingDB(
        email: email, name: name, password: password, type: type);
  }

  bool get isGenuine => !((email == null && password == null) ||
      (email?.isEmail == false && password?.isBlank == true));
}
