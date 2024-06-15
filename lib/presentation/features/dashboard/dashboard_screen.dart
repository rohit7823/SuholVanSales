import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/app/theme/colors.dart';
import 'package:suhol_van_sales/app/theme/images.dart';
import 'package:suhol_van_sales/presentation/utils/extensions.dart';
import 'package:suhol_van_sales/presentation/utils/service_one.dart';
import 'package:suhol_van_sales/presentation/widgets/feature_component.dart';
import 'package:suhol_van_sales/presentation/widgets/service_container.dart';
import 'package:transparent_image/transparent_image.dart';

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
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          sliver: SliverToBoxAdapter(
            child: ColoredBox(
              color: Colors.white,
              child: Row(
                children: [
                  const FeatureComponent(
                          image: Images.walletSVG, name: "DASHBOARD")
                      .expanded(flex: 1),
                  const FeatureComponent(
                          image: Images.targetsSVG, name: "MY TARGETS")
                      .expanded(flex: 1),
                  const FeatureComponent(image: Images.misSVG, name: "MIS")
                      .expanded(flex: 1),
                  const FeatureComponent(
                          image: Images.reportsSVG, name: "REPORTS")
                      .paddings(right: 12)
                ],
              ).paddings(vertical: 12),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 12),
          sliver: SliverToBoxAdapter(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ColoredBox(
                color: AppColors.todayCashSalesColor,
                child: Row(
                  children: [
                    Container(
                      width: Get.width * .5,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: AppColors.todayCashSalesColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Card(
                            color: Colors.white,
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Image.asset(
                              Images.billPaymentSVG,
                              width: 45,
                              height: 45,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "TODAY\nMY CASH SALE",
                                style: Get.textTheme.titleSmall
                                    ?.copyWith(color: Colors.grey),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "OMR ${controller.todayCashSales.value}",
                                style: Get.textTheme.titleLarge
                                    ?.copyWith(color: Colors.black),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: Get.width * .5,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: AppColors.todayCashOrderColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Card(
                            color: Colors.white,
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Image.asset(
                              Images.shopping,
                              width: 45,
                              height: 45,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "TODAY\nMY CASH ORDER",
                                style: Get.textTheme.titleSmall
                                    ?.copyWith(color: Colors.grey),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "${controller.todayCashSales.value}",
                                style: Get.textTheme.titleLarge
                                    ?.copyWith(color: Colors.black),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverAnimatedGrid(
          initialItemCount: ServiceOne.values.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1 / 1,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2),
          itemBuilder: (context, index, animation) {
            var service = ServiceOne.values[index];

            return ServiceContainer(
              name: service.name,
              image: service.image,
              animation: animation.value,
              onClick: () => controller.onTapServiceOne(service),
            );
          },
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          sliver: SliverToBoxAdapter(
            child: FittedBox(
              child: Row(
                children: [
                  Container(
                    width: context.width * .5,
                    color: AppColors.previousCashSaleColor,
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "LAST DAY MY CASH SALE",
                          style: Get.textTheme.titleSmall
                              ?.copyWith(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                        Obx(
                          () => Text(
                            "OMR ${controller.previousDayCashSale.value}",
                            style: Get.textTheme.titleLarge
                                ?.copyWith(color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Container(
                    width: context.width * .5,
                    padding: const EdgeInsets.all(8),
                    color: AppColors.previousCashOrderColor,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "LAST DAY MY CASH ORDER",
                          style: Get.textTheme.titleSmall
                              ?.copyWith(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                        Obx(
                          () => Text(
                            controller.previousDayCashOrder.value,
                            style: Get.textTheme.titleLarge
                                ?.copyWith(color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Obx(() => controller.ads.isNotEmpty
            ? SliverToBoxAdapter(
                child: SizedBox(
                  height: 100,
                  child: ListView.separated(
                    itemCount: controller.ads.length,
                    addAutomaticKeepAlives: false,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 5,
                    ),
                    itemBuilder: (context, index) => Stack(
                      alignment: Alignment.center,
                      children: [
                        FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: controller.ads[index].values.first,
                          fadeInCurve: Curves.easeIn,
                          fadeOutCurve: Curves.easeOut,
                          imageErrorBuilder: (context, error, stackTrace) =>
                              Image.memory(kTransparentImage),
                        ),
                        Text(
                          controller.ads[index].keys.first,
                          style: Get.textTheme.titleMedium
                              ?.copyWith(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink())
      ],
    );
  }

  @override
  void dispose() {
    Get.delete<DashboardController>();
    super.dispose();
  }
}
