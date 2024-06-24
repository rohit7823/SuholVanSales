import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/domain/di/preference_service.dart';
import 'package:suhol_van_sales/domain/models/user_onboarding.dart';
import 'package:suhol_van_sales/presentation/features/signup_screen/signup_repository.dart';
import 'package:suhol_van_sales/presentation/navigation/routes.dart';
import 'package:suhol_van_sales/presentation/utils/login_intent.dart';

class SignupScreenController extends GetxController {
  final _repo = Get.find<SignupRepository>();
  final _pref = Get.find<PreferenceService>();

  var email = TextEditingController();

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

    email.addListener(_inputCheck);
    password.addListener(_inputCheck);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    name.dispose();
    email.dispose();
    password.dispose();
  }

  void _inputCheck() {
    emailObs.value = email.text;
    passWordObs.value = password.text;

    btnState.value = (email.text.isEmail &&
        (password.text.length >= 8 &&
            !(password.text.isAlphabetOnly ||
                password.text.isNumericOnly ||
                password.text.isBlank == true)));
  }

  Future<void> signIn() async {
    loading.value = true;
    var result = await _repo.signIn(UserOnboarding(
        type: oboardingIntent.value.name,
        email: email.text,
        password: password.text));
    loading.value = false;
    if (result != null) {
      _pref.userId("${result.email}_${result.password}");
      Get.offNamed(Routes.home.name);
    } else {
      Get.showSnackbar(const GetSnackBar(
        message: "Account has not been created, yet.",
        duration: Duration(seconds: 5),
      ));
    }
  }

  Future<void> signUp() async {
    loading.value = true;
    int? userId;
    try {
      userId = await _repo.signUp(UserOnboarding(
          type: oboardingIntent.value.name,
          email: email.text,
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
    email.text = '';
  }

  Future<void> forgotPassword() async {
    if (!email.text.isEmail) {}
    var result = await _repo.forgotPassword(email.text);
    if (result != null) {}
  }

  var isPasswordVisible = false.obs;

  void toggleVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
