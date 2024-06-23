import 'package:get/get.dart';
import 'package:suhol_van_sales/data/repo_impls/signup_repository_impl.dart';
import 'package:suhol_van_sales/presentation/features/signup_screen/signup_repository.dart';

import 'signup_screen_controller.dart';

class SignupScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupRepository>(() => SignupRepositoryImpl());
    Get.lazyPut(() => SignupScreenController());
  }
}
