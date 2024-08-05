import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/data/utils/extensions.dart';
import 'package:suhol_van_sales/domain/data_source/local/user_onboarding/dao/user_onboarding_dao.dart';
import 'package:suhol_van_sales/domain/data_source/remote/login/response/user_onboarding_response.dart';
import 'package:suhol_van_sales/domain/data_source/remote/logout/response/sign_out_user_response.dart';
import 'package:suhol_van_sales/domain/data_source/remote/web_service_pool.dart';
import 'package:suhol_van_sales/domain/di/session_service.dart';
import 'package:suhol_van_sales/domain/models/user_onboarding.dart';
import 'package:suhol_van_sales/domain/utils/response.dart';
import 'package:suhol_van_sales/presentation/features/signup_screen/signup_repository.dart';

class SignupRepositoryImpl extends SignupRepository
    with UserOnboardingDao, WebServicePool {
  final _session = Get.find<SessionService>();

  @override
  Future<UserOnboarding?> forgotPassword(String email) async {
    var value = await getByEmail(email);

    return value?.toData;
  }

  @override
  Future<UserOnboardingResponse?> signIn(UserOnboarding data) async {
    /*var value = await get(data);

    return value?.toData;*/

    var response = await login(data);
    if (response is Success) {
      httpClient.addAuthHeader(response.data?.token);
      _session.registerAppToken(response.data?.token);
      return response.data;
    } else if (response is Error) {
      debugPrint("Error: ${response.message}");
      return null;
    }

    return null;
  }

  @override
  Future<int?> signUp(UserOnboarding data) async {
    return await insert(data);
  }

  @override
  Future<SignOutUserResponse?> signOut() async {
    var response = await logout();

    if (response is Success) {
      httpClient.removeAuthHeader();
      _session.unregisterAppToken();
      return response.data;
    } else if (response is Error) {
      debugPrint("Error: ${response.message}");
      return null;
    }

    return null;
  }
}
