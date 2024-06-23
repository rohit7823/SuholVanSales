import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/presentation/widgets/app_button.dart';
import 'package:suhol_van_sales/presentation/widgets/app_text_field.dart';

class FieldsCard extends StatelessWidget {
  const FieldsCard(
      {super.key, required this.fields, required this.button, this.optional});

  final List<AppTextField> fields;
  final AppButton button;
  final Widget Function(BuildContext context, StateSetter setState)? optional;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: Get.width * .05, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 7,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 700),
          curve: Curves.fastLinearToSlowEaseIn,
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ..._addWithSeperators(fields),
              SizedBox(
                height: Get.height * .08,
              ),
              StatefulBuilder(
                  builder: optional ??
                      (context, setState) => const SizedBox.shrink()),
              button,
              SizedBox(
                height: Get.height * .03,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _addWithSeperators(List<AppTextField> fields) {
    List<Widget> tmp = [];

    for (var field in fields) {
      tmp.add(SizedBox(
        height: Get.height * .05,
      ));
      tmp.add(field);
    }

    return tmp;
  }
}
