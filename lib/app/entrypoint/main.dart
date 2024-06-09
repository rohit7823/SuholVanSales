import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/app/theme/fonts.dart';
import 'package:suhol_van_sales/domain/di/service_binding.dart';
import 'package:suhol_van_sales/presentation/navigation/main_graph.dart';
import 'package:suhol_van_sales/presentation/navigation/routes.dart';
import 'package:suhol_van_sales/presentation/utils/constants.dart';

void main() {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
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
        typography: Typography.material2021(),
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        fontFamily: Fonts.joseFinSans,
        brightness: Brightness.light,
      ),
      initialBinding: ServiceBindings(),
      getPages: MainGraph.instance.routes(),
      useInheritedMediaQuery: false,
      initialRoute: Routes.features.name,
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior(),
    );
  }
}
