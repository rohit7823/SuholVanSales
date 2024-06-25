import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/presentation/utils/extensions.dart';

class KeyboardAwareWidget extends StatelessWidget {
  const KeyboardAwareWidget(
      {super.key, required this.child, this.paddingDecreser});

  final Widget child;
  final double? paddingDecreser;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.isKeyboardVisible
          ? EdgeInsets.only(
              bottom: Get.mediaQuery.viewInsets.bottom / (paddingDecreser ?? 1)
          )
          : EdgeInsets.zero,
      child: child,
    );
  }
}
