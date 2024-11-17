import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/data/repo_impls/create_order_repository_impl.dart';
import 'package:suhol_van_sales/domain/di/session_service.dart';
import 'package:suhol_van_sales/presentation/navigation/home_graph.dart';
import 'package:suhol_van_sales/presentation/navigation/routes.dart';
import 'package:suhol_van_sales/presentation/utils/mrorder_types.dart';

class MrOrderScreenController extends GetxController {
  final session = Get.find<SessionService>();
  final _repo = Get.find<CreateOrderRepositoryImpl>();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void pop() {
    HomeGraph.instance.pop();
  }

  void onTapMROrder(MrOrderTypes type) {
    switch (type) {
      case MrOrderTypes.mrCreate:
        Get.toNamed(Routes.createMrorder.name);
      case MrOrderTypes.mrOrders:
      // TODO: Handle this case.
      case MrOrderTypes.mrApproved:
      // TODO: Handle this case.
    }
  }

  void onClickFeature(String componentName) {
    log("component name $componentName");
    if (componentName.toLowerCase().contains("data sync")) {
      Get.showSnackbar(const GetSnackBar(
        message: "Sync started!!",
        duration: Duration(seconds: 5),
        showProgressIndicator: true,
        progressIndicatorValueColor:
            AlwaysStoppedAnimation(CupertinoColors.destructiveRed),
      ));
      _repo.sync().then(
        (value) {
          Get.showSnackbar(const GetSnackBar(
            message: "Data is updated with server!!",
            duration: Duration(seconds: 5),
          ));
        },
      );
    }
  }
}
