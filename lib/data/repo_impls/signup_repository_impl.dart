import 'package:suhol_van_sales/data/utils/extensions.dart';
import 'package:suhol_van_sales/domain/data_source/local/user_onboarding/dao/user_onboarding_dao.dart';
import 'package:suhol_van_sales/domain/models/user_onboarding.dart';
import 'package:suhol_van_sales/presentation/features/signup_screen/signup_repository.dart';

class SignupRepositoryImpl extends SignupRepository with UserOnboardingDao {
  @override
  Future<UserOnboarding?> forgotPassword(String email) async {
    var value = await getByEmail(email);

    return value?.toData;
  }

  @override
  Future<UserOnboarding?> signIn(UserOnboarding data) async {
    var value = await get(data);

    return value?.toData;
  }

  @override
  Future<int?> signUp(UserOnboarding data) async {
    return await insert(data);
  }
}
