import 'package:get/get.dart';
import 'package:suhol_van_sales/data/di/customers_binding.dart';
import 'package:suhol_van_sales/domain/di/database_service.dart';
import 'package:suhol_van_sales/domain/di/preference_service.dart';
import 'package:suhol_van_sales/domain/di/rest_service.dart';

class ServiceBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    await Get.putAsync(() async {
      return await DatabaseService().init();
    });


    await Get.putAsync(() async {
      return await PreferenceService().init();
    });

    await Get.putAsync(() async {
      return await RestService().init();
    });
  }
}
