import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/presentation/features/features_screen/features_screen_binding.dart';
import 'package:suhol_van_sales/presentation/features/features_screen/features_screen_view.dart';

import 'routes.dart';

class MainGraph {
  MainGraph._();

  static MainGraph get instance => MainGraph._();

  List<GetPage> routes() => [
        GetPage<Routes>(
            name: Routes.features.name,
            page: () => const FeaturesScreen(),
            binding: FeaturesScreenBinding(),
            maintainState: true,
            popGesture: true,
            preventDuplicates: true,
            transition: Transition.leftToRightWithFade,
            curve: Curves.slowMiddle)
      ];
}
