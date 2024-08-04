import 'package:suhol_van_sales/domain/data_source/remote/login/response/user_onboarding_response.dart';
import 'package:suhol_van_sales/domain/models/user_onboarding.dart';

abstract class SignupRepository {
  Future<int?> signUp(UserOnboarding data);
  Future<UserOnboardingResponse?> signIn(UserOnboarding data);
  Future<UserOnboarding?> forgotPassword(String email);
}
