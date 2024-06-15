import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/app/theme/images.dart';
import 'package:suhol_van_sales/presentation/utils/cash_order_history_types.dart';
import 'package:suhol_van_sales/presentation/utils/extensions.dart';
import 'package:suhol_van_sales/presentation/widgets/feature_component.dart';
import 'package:suhol_van_sales/presentation/widgets/service_container.dart';

import 'cash_sales_order_controller.dart';

class CashSalesOrder extends StatefulWidget {
  const CashSalesOrder({super.key});

  @override
  State<CashSalesOrder> createState() => _CashSalesOrderState();
}

class _CashSalesOrderState extends State<CashSalesOrder> {
  final controller = Get.find<CashSalesOrderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.primary,
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            sliver: SliverToBoxAdapter(
              child: ColoredBox(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: controller.pop,
                          child: const Icon(
                            Icons.arrow_back_sharp,
                            color: Colors.grey,
                          )),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        "Cash Sales Order",
                        style: Get.textTheme.titleMedium?.copyWith(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 12),
            sliver: SliverToBoxAdapter(
              child: ColoredBox(
                color: Colors.white,
                child: Row(
                  children: [
                    const FeatureComponent(
                            image: Images.walletSVG, name: "Date")
                        .expanded(flex: 1),
                    const FeatureComponent(
                            image: Images.targetsSVG, name: "Location")
                        .expanded(flex: 1),
                    const FeatureComponent(
                            image: Images.misSVG, name: "Printer")
                        .expanded(flex: 1),
                    const FeatureComponent(
                            image: Images.reportsSVG, name: "Data Sync")
                        .paddings(right: 12)
                  ],
                ).paddings(vertical: 12),
              ),
            ),
          ),
          SliverAnimatedGrid(
            initialItemCount: CashOrderHistoryTypes.values.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1 / 1,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2),
            itemBuilder: (context, index, animation) {
              var type = CashOrderHistoryTypes.values[index];

              return ServiceContainer(
                name: type.name,
                image: type.image,
                animation: animation.value,
                onClick: () => controller.onTapCashHistory(type),
              );
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<CashSalesOrderController>();
    super.dispose();
  }
}
