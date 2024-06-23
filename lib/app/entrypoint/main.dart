import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/app/theme/colors.dart';
import 'package:suhol_van_sales/app/theme/fonts.dart';
import 'package:suhol_van_sales/domain/di/service_binding.dart';
import 'package:suhol_van_sales/presentation/navigation/main_graph.dart';
import 'package:suhol_van_sales/presentation/navigation/routes.dart';
import 'package:suhol_van_sales/presentation/utils/constants.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await ServiceBindings().dependencies();
      runApp(const SuholVanSales());
    },
    (error, stack) {
      debugPrint("FETAL ERROR $error\n\n$stack");
    },
  );
}

class SuholVanSales extends StatelessWidget {
  const SuholVanSales({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Constants.appName,
      theme: ThemeData(
        useMaterial3: false,
        colorScheme: AppColors.mainColorScheme,
        fontFamily: Fonts.poppinsRegular,
      ),
      getPages: MainGraph.instance.routes(),
      useInheritedMediaQuery: false,
      initialRoute: Routes.signup.name,
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior(),
    );
  }
}
