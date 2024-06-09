import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/app/theme/fonts.dart';
import 'package:suhol_van_sales/presentation/utils/extensions.dart';
import 'package:suhol_van_sales/presentation/utils/features.dart';
import 'package:suhol_van_sales/presentation/widgets/my_app_bar.dart';

import 'features_screen_controller.dart';

class FeaturesScreen extends StatefulWidget {
  const FeaturesScreen({super.key});

  @override
  State<FeaturesScreen> createState() => _FeaturesScreenState();
}

class _FeaturesScreenState extends State<FeaturesScreen> {
  final controller = Get.find<FeaturesScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        bgColor: Get.theme.colorScheme.primary,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Suhol Al Fayha",
              style: Get.textTheme.titleLarge!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w900),
            ),
            Text(
              DateTime.now().currentDate(),
              style: Get.textTheme.titleSmall!.copyWith(color: Colors.white),
            )
          ],
        ),
        isTitleCenter: false,
        actions: [
          IconButton(
              onPressed: controller.onTapCalender,
              icon: const Icon(
                Icons.calendar_today,
                color: Colors.white,
              )),
          IconButton(
              onPressed: controller.onTapSettings,
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ))
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12),
        child: CustomScrollView(
          slivers: [
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () =>
                        controller.onTapFeature(Features.values[index]),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: ColoredBox(
                            color: Get.theme.colorScheme.primary,
                            child: Icon(
                              Features.values[index].icon,
                              color: Colors.white,
                              size: 45,
                            ).paddings(all: 12),
                          ),
                        ).paddings(all: 12),
                        Text(
                          Features.values[index].name,
                          style: Get.textTheme.titleLarge!.copyWith(
                              fontFamily: Fonts.joseFinSansBold,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                childCount: Features.values.length,
              ),
            )
          ],
        ),
      )),
    );
  }

  @override
  void dispose() {
    Get.delete<FeaturesScreenController>();
    super.dispose();
  }
}
