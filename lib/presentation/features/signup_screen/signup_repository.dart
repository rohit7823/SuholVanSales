import 'package:suhol_van_sales/domain/models/user_onboarding.dart';

abstract class SignupRepository {
  Future<int?> signUp(UserOnboarding data);
  Future<UserOnboarding?> signIn(UserOnboarding data);
  Future<UserOnboarding?> forgotPassword(String email);
}
