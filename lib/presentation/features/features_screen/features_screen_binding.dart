import 'package:get/get.dart';

import 'features_screen_controller.dart';

class FeaturesScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FeaturesScreenController());
  }
}
