import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/app/theme/colors.dart';
import 'package:suhol_van_sales/app/theme/images.dart';
import 'package:suhol_van_sales/presentation/utils/extensions.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key, required this.userName, required this.shopName});

  final RxString userName;
  final RxString shopName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundColor: AppColors.primary,
          foregroundImage: AssetImage(Images.person),
        ).paddings(right: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Text(
                "Hi, ${userName.value}",
                style: Get.textTheme.titleLarge,
              )),
              Obx(() => Text("Today Mon, 17 sep - ${shopName.value}", style: Get.textTheme.titleSmall))
            ],
          ),
        )
      ],
    );
  }
}
