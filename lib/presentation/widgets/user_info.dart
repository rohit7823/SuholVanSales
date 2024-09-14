import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:suhol_van_sales/app/theme/colors.dart';
import 'package:suhol_van_sales/app/theme/images.dart';
import 'package:suhol_van_sales/presentation/utils/extensions.dart';

class UserInfo extends StatelessWidget {
  const UserInfo(
      {super.key,
      required this.userName,
      required this.shopName,
      this.back,
      this.menu});

  final RxString userName;
  final RxString shopName;
  final void Function()? back;
  final void Function()? menu;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        back != null && menu == null
            ? InkWell(
                onTap: back,
                child: const Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.grey,
                )).paddings(right: 8)
            : const SizedBox.shrink(),
        menu != null && back == null
            ? InkWell(
                onTap: menu,
                child: const Icon(
                  Icons.menu,
                  color: Colors.grey,
                )).paddings(right: 8)
            : const SizedBox.shrink(),
        const CircleAvatar(
          backgroundColor: AppColors.primary,
          foregroundImage: AssetImage(Images.person),
          maxRadius: 24,
        ).paddings(right: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Text(
                    "Hi, ${userName.value}",
                    style: Get.textTheme.titleLarge,
                  )),
              Obx(() => Text("${_date(DateTime.now())}  ${shopName.value}",
                  style: Get.textTheme.titleSmall))
            ],
          ),
        )
      ],
    );
  }

  String _date(DateTime dateTime) {
    var formatter = DateFormat("EEE dd MMM");
    var formattedDate = formatter.format(dateTime);
    return "Today $formattedDate";
  }
}
