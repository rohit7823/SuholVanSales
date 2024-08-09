import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/domain/di/preference_service.dart';
import 'package:suhol_van_sales/domain/di/rest_service.dart';
import 'package:suhol_van_sales/domain/di/session_service.dart';
import 'package:suhol_van_sales/domain/models/user_onboarding.dart';
import 'package:suhol_van_sales/presentation/features/signup_screen/signup_repository.dart';
import 'package:suhol_van_sales/presentation/navigation/routes.dart';
import 'package:suhol_van_sales/presentation/utils/login_intent.dart';

class SignupScreenController extends GetxController {
  final _repo = Get.find<SignupRepository>();
  final _session = Get.find<SessionService>();

  var emailOrName = TextEditingController();

  var password = TextEditingController();

  Rx<LoginIntent> oboardingIntent = Rx(LoginIntent.signIn);

  var name = TextEditingController();

  var loading = false.obs;

  var btnState = false.obs;

  var emailObs = ''.obs;
  var passWordObs = ''.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    emailOrName.addListener(_inputCheck);
    password.addListener(_inputCheck);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    name.dispose();
    emailOrName.dispose();
    password.dispose();
  }

  void _inputCheck() {
    emailObs.value = emailOrName.text;
    passWordObs.value = password.text;

    btnState.value = (emailOrName.text.isEmail ||
            emailOrName.text.isBlank == false) &&
        (password.text.length >=
            8); /*&&
                !(password.text.isAlphabetOnly ||
                    password.text.isNumericOnly ||
                    password.text.isBlank == true)));*/
  }

  Future<void> signIn() async {
    loading.value = true;
    var result = await _repo.signIn(UserOnboarding(
        type: oboardingIntent.value.name,
        email: emailOrName.text,
        password: password.text));
    loading.value = false;
    //Get.offNamed(Routes.home.name);
    if (result != null && result.status == true) {
      fetchUserDetails();
      Get.offNamed(Routes.home.name);
    } else {
      Get.showSnackbar(GetSnackBar(
        message: "${result?.message}",
        duration: const Duration(seconds: 5),
      ));
    }
  }

  Future<void> signUp() async {
    loading.value = true;
    int? userId;
    try {
      userId = await _repo.signUp(UserOnboarding(
          type: oboardingIntent.value.name,
          email: emailOrName.text,
          password: password.text,
          name: name.text));
    } on Exception catch (ex) {
      Get.showSnackbar(GetSnackBar(
        message: ex.toString(),
        duration: const Duration(seconds: 5),
      ));
    } finally {
      loading.value = false;
      if (userId != null) {
        oboardingIntent.value = LoginIntent.signIn;
        Get.showSnackbar(const GetSnackBar(
          message: "Account has been created, please sign-up to your account.",
          duration: Duration(seconds: 5),
        ));
      }
    }
  }

  void changeIntent() {
    oboardingIntent.value = oboardingIntent.value == LoginIntent.signUp
        ? LoginIntent.signIn
        : LoginIntent.signUp;
    password.text = '';
    emailOrName.text = '';
  }

  Future<void> forgotPassword() async {
    if (!emailOrName.text.isEmail) {}
    var result = await _repo.forgotPassword(emailOrName.text);
    if (result != null) {}
  }

  var isPasswordVisible = false.obs;

  void toggleVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> fetchUserDetails() async {
    var result = await _repo.fetchUserDetails();
    if (result != null) {
      _session.injectUserDetails(result);
    }
  }
}
