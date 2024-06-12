import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/app/theme/fonts.dart';
import 'package:suhol_van_sales/app/theme/images.dart';
import 'package:suhol_van_sales/presentation/utils/extensions.dart';

import 'dashboard_controller.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: ColoredBox(
            color: Colors.white,
            child: Row(
              children: [
                Column(
                  children: [
                    SvgPicture.asset(Images.walletSVG),
                    const SizedBox(height: 12,),
                    Text("DASHBOARD", style: Get.textTheme.labelSmall?.copyWith(
                        color: Colors.grey
                    ),)
                  ],
                ).expanded(flex: 1),
                Column(
                  children: [
                    SvgPicture.asset(Images.targetsSVG),
                    const SizedBox(height: 12,),
                    Text("TARGETS", style: Get.textTheme.labelSmall?.copyWith(
                        color: Colors.grey
                    ),)
                  ],
                ).expanded(flex: 1),
                Column(
                  children: [
                    SvgPicture.asset(Images.misSVG),
                    const SizedBox(height: 12,),
                    Text("MIS", style: Get.textTheme.labelSmall?.copyWith(
                        color: Colors.grey
                    ),)
                  ],
                ).expanded(flex: 1),
                Column(
                  children: [
                    SvgPicture.asset(Images.reportsSVG),
                    const SizedBox(height: 12,),
                    Text("REPORTS", style: Get.textTheme.labelSmall?.copyWith(
                        color: Colors.grey
                    ),)
                  ],
                ).paddings(right: 12)
              ],
            ).paddings(vertical: 12),
          ),
        ),

      ],
    );
  }

  @override
  void dispose() {
    Get.delete<DashboardController>();
    super.dispose();
  }
}