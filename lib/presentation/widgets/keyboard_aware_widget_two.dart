import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KeyboardAwareWidgetTwo extends StatelessWidget {
  const KeyboardAwareWidgetTwo({super.key, required this.child});

  final Widget Function(
      BuildContext context, double height, bool isHeightInfinite) child;

  @override
  Widget build(BuildContext context) {
    var bottomInsets = Get.mediaQuery.viewInsets.bottom;
    var height = context.height;
    var availableHeight = height - bottomInsets;
    return SizedBox(
        height: bottomInsets == 0.0 ? null : availableHeight,
        child: LayoutBuilder(builder: (context, constraints) {
          var height = constraints.maxHeight;
          return child(context, height, height.isInfinite);
        }));
  }
}
