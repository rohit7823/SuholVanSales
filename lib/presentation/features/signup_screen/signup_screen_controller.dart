import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/domain/models/user_onboarding.dart';
import 'package:suhol_van_sales/presentation/features/signup_screen/signup_repository.dart';
import 'package:suhol_van_sales/presentation/navigation/routes.dart';
import 'package:suhol_van_sales/presentation/utils/login_intent.dart';

class SignupScreenController extends GetxController {
  final _repo = Get.find<SignupRepository>();

  var email = TextEditingController();

  var password = TextEditingController();

  Rx<LoginIntent> oboardingIntent = Rx(LoginIntent.signIn);

  var name = TextEditingController();

  var loading = false.obs;

  var btnState = false.obs;

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
    btnState.value = (email.text.isEmail &&
        (password.text.length == 8 &&
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
      Get.offNamed(Routes.home.name);
    }
  }

  Future<void> signUp() async {
    loading.value = true;
    var userId = await _repo.signUp(UserOnboarding(
        type: oboardingIntent.value.name,
        email: email.text,
        password: password.text,
        name: name.text));
    loading.value = false;
    if (userId != null) {
      Get.offNamed(Routes.home.name);
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
}
