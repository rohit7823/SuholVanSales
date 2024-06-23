import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/app/theme/colors.dart';
import 'package:suhol_van_sales/app/theme/fonts.dart';
import 'package:suhol_van_sales/presentation/utils/extensions.dart';
import 'package:suhol_van_sales/presentation/utils/login_intent.dart';
import 'package:suhol_van_sales/presentation/widgets/app_button.dart';
import 'package:suhol_van_sales/presentation/widgets/app_text_field.dart';
import 'package:suhol_van_sales/presentation/widgets/fields_card.dart';
import 'package:suhol_van_sales/presentation/widgets/keyboard_aware_widget.dart';

import 'signup_screen_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with WidgetsBindingObserver {
  final controller = Get.find<SignupScreenController>();
  RxDouble bottomInsets = 0.0.obs;
  String email = '';
  String pass = '';

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeMetrics() {
    bottomInsets.value = WidgetsBinding.instance.window.viewInsets.bottom;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  color: AppColors.secondary,
                ),
              ),
              Expanded(
                child: Container(
                  color: Get.theme.colorScheme.primary,
                ),
              )
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "WELCOME",
                  style: Get.textTheme.headlineLarge?.copyWith(
                      color: Colors.white, fontFamily: Fonts.poppinsBold),
                ),
              ).paddings(horizontal: Get.width * .05),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Please login to your account",
                  style:
                      Get.textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
              ).paddings(horizontal: Get.width * .05),
              Obx(() => KeyboardAwareWidget(
                  paddingDecreser:
                      controller.oboardingIntent.value == LoginIntent.signUp
                          ? 1.5
                          : null,
                  child: FieldsCard(
                    fields:
                        controller.oboardingIntent.value == LoginIntent.signIn
                            ? [
                                AppTextField(
                                  controller: controller.email,
                                  autoFocus: true,
                                  changeStyle: true,
                                  label: "Email",
                                  borderColor: AppColors.secondary,
                                ),
                                AppTextField(
                                  controller: controller.password,
                                  autoFocus: true,
                                  changeStyle: true,
                                  label: "Password",
                                  isObscure: true,
                                  borderColor: AppColors.secondary,
                                ),
                              ]
                            : [
                                AppTextField(
                                  controller: controller.name,
                                  autoFocus: true,
                                  changeStyle: true,
                                  label: "Name",
                                  borderColor: AppColors.secondary,
                                  keyboardType: TextInputType.text,
                                  inputAction: TextInputAction.next,
                                ),
                                AppTextField(
                                  controller: controller.email,
                                  autoFocus: true,
                                  changeStyle: true,
                                  label: "Email",
                                  borderColor: AppColors.secondary,
                                  inputAction: TextInputAction.next,
                                ),
                                AppTextField(
                                  controller: controller.password,
                                  autoFocus: true,
                                  changeStyle: true,
                                  label: "Password",
                                  isObscure: true,
                                  borderColor: AppColors.secondary,
                                )
                              ],
                    button: AppButton(
                      onClick:
                          controller.oboardingIntent.value == LoginIntent.signIn
                              ? controller.signIn
                              : controller.signUp,
                      label:
                          controller.oboardingIntent.value == LoginIntent.signUp
                              ? "Sign Up"
                              : "Sign In",
                      labelColor: Colors.black54,
                      btnColor: AppColors.secondary,
                      height: 45,
                      border: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    optional: (context, setState) {
                      setState(() {
                        email = controller.email.text;
                        pass = controller.password.text;
                      });

                      return ValueListenableBuilder(
                        valueListenable: ,
                        builder: (context, value, child) {},
                      );

                      return email.isBlank == true
                          ? const SizedBox.shrink()
                          : !email.isEmail
                              ? Text(
                                  "*invalid email",
                                  style: Get.textTheme.labelSmall
                                      ?.copyWith(color: Colors.redAccent),
                                )
                              : pass.isBlank == true
                                  ? const SizedBox.shrink()
                                  : !pass.isPassword
                                      ? Text(
                                          "*invalid password",
                                          style: Get.textTheme.labelSmall
                                              ?.copyWith(
                                                  color: Colors.redAccent),
                                        )
                                      : const SizedBox.shrink();
                    },
                  ))),
              SizedBox(
                height: Get.height * .03,
              ),
              TextButton(
                  onPressed: controller.changeIntent,
                  child: Obx(() => Text(
                        controller.oboardingIntent.value == LoginIntent.signUp
                            ? "Sign in"
                            : "Sign up",
                        style: Get.textTheme.titleMedium?.copyWith(
                            color: AppColors.buttonColorAlternate,
                            fontFamily: Fonts.poppinsSemiBold),
                      ))),
              SizedBox(
                height: Get.height * .03,
              ),
              Obx(() => controller.oboardingIntent.value == LoginIntent.signIn
                  ? TextButton(
                      onPressed: controller.forgotPassword,
                      child: Text(
                        "Forgot Password?",
                        style: Get.textTheme.titleMedium?.copyWith(
                            color: Colors.grey.shade300,
                            fontFamily: Fonts.poppinsSemiBold),
                      ),
                    )
                  : const SizedBox.shrink()),
              SizedBox(
                height: Get.height * .03,
              )
            ],
          )
        ],
      )),
    );
  }

  @override
  void dispose() {
    Get.delete<SignupScreenController>();
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}
