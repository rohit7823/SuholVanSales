import 'package:get/get.dart';
import 'package:suhol_van_sales/domain/data_source/local/user_onboarding/entities/user_onboarding.dart';
import 'package:suhol_van_sales/domain/di/database_service.dart';
import 'package:suhol_van_sales/domain/models/user_onboarding.dart';
import 'package:suhol_van_sales/domain/utils/extenstions.dart';
import 'package:suhol_van_sales/objectbox.g.dart';

mixin UserOnboardingDao {
  final _db = Get.find<DatabaseService>().db?.box<UserOnboardingDB>();

  Future<UserOnboardingDB?> get(UserOnboarding data) async {
    if (!data.isGenuine) {
      return null;
    }

    return await _db
        ?.query(UserOnboardingDB_.email.equals(data.email!) &
            UserOnboardingDB_.password.equals(data.password!))
        .build()
        .findUniqueAsync();
  }

  Future<UserOnboardingDB?> getByEmail(String email) async {
    return await _db
        ?.query(UserOnboardingDB_.email.equals(email))
        .build()
        .findUniqueAsync();
  }

  Future<int?> insert(UserOnboarding data) async {
    var value = await get(data);

    if (value != null) {
      throw Exception("${data.name} is already has an account!");
    }

    if (!data.isGenuine) {
      throw Exception("email and password cannot be empty");
    }

    return await _db?.putAsync(data.toDb);
  }

  Future<bool?> delete(int? id, {UserOnboarding? data}) async {
    if (data != null) {
      var value = await _db
          ?.query(UserOnboardingDB_.email.equals(data.email ?? '') &
              UserOnboardingDB_.password.equals(data.password ?? ''))
          .build()
          .findUniqueAsync();

      if (value != null) {
        return await _db?.removeAsync(value.id!);
      } else {
        return null;
      }
    }

    return await _db?.removeAsync(id!);
  }
}
