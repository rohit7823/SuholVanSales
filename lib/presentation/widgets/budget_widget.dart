import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/fonts.dart';

class BudgetWidget extends StatelessWidget {
  const BudgetWidget(
      {super.key, required this.items, required this.vat, required this.total});

  final String items;
  final String vat;
  final String total;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Get.theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        child: FittedBox(
          child: Row(
            children: [
              Text(
                "Product: $items",
                style: Get.textTheme.titleLarge?.copyWith(
                    color: const Color(0xFF092058),
                    fontFamily: Fonts.poppinsSemiBold),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * .10),
                child: Text(
                  "VAT: $vat",
                  style: Get.textTheme.titleLarge?.copyWith(
                      color: const Color(0xFF092058),
                      fontFamily: Fonts.poppinsSemiBold),
                ),
              ),
              Text(
                "Total: $total",
                style: Get.textTheme.titleLarge?.copyWith(
                    color: const Color(0xFF092058),
                    fontFamily: Fonts.poppinsSemiBold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
