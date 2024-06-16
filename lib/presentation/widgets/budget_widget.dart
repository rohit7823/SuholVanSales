import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/fonts.dart';

class BudgetWidget extends StatelessWidget {
  const BudgetWidget(
      {super.key, required this.items, required this.vat, required this.total});

  final RxString items;
  final RxString vat;
  final RxString total;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Get.theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: FittedBox(
          child: Row(
            children: [
              Obx(
                () => Text(
                  "Item: ${items.value}",
                  style: Get.textTheme.titleLarge?.copyWith(
                      color: const Color(0xFF092058),
                      fontFamily: Fonts.poppinsSemiBold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * .10),
                child: Obx(
                  () => Text(
                    "VAT: ${vat.value}",
                    style: Get.textTheme.titleLarge?.copyWith(
                        color: const Color(0xFF092058),
                        fontFamily: Fonts.poppinsSemiBold),
                  ),
                ),
              ),
              Obx(
                () => Text(
                  "Total: ${total.value}",
                  style: Get.textTheme.titleLarge?.copyWith(
                      color: const Color(0xFF092058),
                      fontFamily: Fonts.poppinsSemiBold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
