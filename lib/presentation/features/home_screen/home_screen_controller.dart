import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/app/theme/fonts.dart';
import 'package:suhol_van_sales/data/di/customers_binding.dart';
import 'package:suhol_van_sales/domain/di/preference_service.dart';
import 'package:suhol_van_sales/presentation/features/signup_screen/signup_repository.dart';
import 'package:suhol_van_sales/presentation/navigation/home_graph.dart';
import 'package:suhol_van_sales/presentation/navigation/routes.dart';
import 'package:suhol_van_sales/presentation/utils/bottom_menus.dart';

import '../../../domain/di/rest_service.dart';
import '../../../domain/di/session_service.dart';

class HomeScreenController extends GetxController {
  final _prefs = Get.find<PreferenceService>();
  final _signUpRepo = Get.find<SignupRepository>();

  var isLoggedIn = false.obs;

  var userName = "Marcel".obs;

  var shopName = "Shop 01".obs;

  Rx<BottomMenus> selectedBottomMenu = BottomMenus.home.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    isLoggedIn.value = _prefs.userID.isBlank == false;
    userName.value = _prefs.userName?.split(" ").first ?? "Welcome";
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void onSelectBottomMenu(int value) {
    selectedBottomMenu.value = BottomMenus.values.firstWhere(
      (element) => element.index == value,
      orElse: () => BottomMenus.home,
    );

    if (selectedBottomMenu.value case BottomMenus.signOut) {
      Get.defaultDialog(
          title: "Logout",
          content: Text(
            "Are you sure to logout?",
            style: Get.textTheme.titleMedium?.copyWith(
                color: Colors.black, fontFamily: Fonts.poppinsSemiBold),
          ),
          actions: [
            TextButton(
                onPressed: _logout,
                child: Text(
                  "Yes",
                  style: Get.textTheme.titleSmall?.copyWith(
                      color: Colors.black54, fontFamily: Fonts.poppinsSemiBold),
                )),
            TextButton(
                onPressed: () {
                  if (Get.isDialogOpen == true) {
                    Navigator.of(Get.overlayContext!).pop();
                  }
                },
                child: Text(
                  "No",
                  style: Get.textTheme.titleSmall?.copyWith(
                      color: Colors.black54, fontFamily: Fonts.poppinsSemiBold),
                ))
          ]);
    }
  }

  bool onChildPop(Route route, result) {
    debugPrint("route ${route.settings.name}");
    return true;
  }

  void backPress(bool didPop) {
    var navState = Get.nestedKey(HomeGraph.instance.navKey)?.currentState;

    if (navState?.canPop() == true) {
      navState?.pop();
    } else {
      Get.back();
    }
  }

  void login() {
    Get.offAndToNamed(Routes.signup.name);
  }

  void _logout() async {
    await _signUpRepo.signOut().then((value) {
      switch (value?.status) {
        case true:
          Get.offAllNamed(Routes.signup.name);
          break;
        case false:
          Get.showSnackbar(GetSnackBar(
            message: "${value?.message}",
            duration: const Duration(seconds: 5),
          ));
          break;
        case null:
          break;
      }
    }, onError: (object) {
      debugPrint("onLogout ${object.toString()}");
    });
  }
}
