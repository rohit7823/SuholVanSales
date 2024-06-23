import 'package:suhol_van_sales/domain/data_source/local/user_onboarding/entities/user_onboarding.dart';
import 'package:suhol_van_sales/domain/models/user_onboarding.dart';

extension OnboardingDbLayerExts on UserOnboardingDB {
  UserOnboarding get toData =>
      UserOnboarding(type: type, password: password, name: name, email: email);
}
