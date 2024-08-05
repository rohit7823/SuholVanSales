import 'package:suhol_van_sales/domain/data_source/remote/login/response/user_onboarding_response.dart';
import 'package:suhol_van_sales/domain/data_source/remote/logout/response/sign_out_user_response.dart';
import 'package:suhol_van_sales/domain/models/user_onboarding.dart';
import 'package:suhol_van_sales/domain/utils/response.dart';

abstract class SignupRepository {
  Future<int?> signUp(UserOnboarding data);
  Future<UserOnboardingResponse?> signIn(UserOnboarding data);
  Future<UserOnboarding?> forgotPassword(String email);
  Future<SignOutUserResponse?> signOut();
}
