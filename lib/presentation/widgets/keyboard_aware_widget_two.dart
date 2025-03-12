import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/presentation/utils/extensions.dart';

class KeyboardAwareWidgetTwo extends StatelessWidget {
  const KeyboardAwareWidgetTwo(
      {super.key, required this.child, this.preferredHeight});

  final double? preferredHeight;

  final Widget Function(
      BuildContext context, double height, bool isHeightInfinite) child;

  @override
  Widget build(BuildContext context) {
    var bottomInsets = Get.mediaQuery.viewInsets.bottom;
    var height = context.height;
    var availableHeight = (preferredHeight ?? height) - bottomInsets;
    return SizedBox(
        height: bottomInsets == 0.0 ? null : availableHeight,
        child: LayoutBuilder(builder: (context, constraints) {
          var height = constraints.maxHeight;
          return child(context, height, height.isInfinite)
              .align(alignment: Alignment.center);
        }));
  }
}
