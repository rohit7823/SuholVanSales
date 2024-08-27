import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/app/theme/images.dart';
import 'package:suhol_van_sales/presentation/utils/credit_order_history_types.dart';
import 'package:suhol_van_sales/presentation/utils/extensions.dart';
import 'package:suhol_van_sales/presentation/widgets/feature_component.dart';
import 'package:suhol_van_sales/presentation/widgets/service_container.dart';

import '../../utils/features.dart';
import 'credit_sales_order_controller.dart';

class CreditSalesOrder extends StatefulWidget {
  const CreditSalesOrder({super.key});

  @override
  State<CreditSalesOrder> createState() => _CreditSalesOrderState();
}

class _CreditSalesOrderState extends State<CreditSalesOrder> {
  final controller = Get.find<CreditSalesOrderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.primary,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
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
                        "Credit Sales Order",
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: Features.values.map(
                    (feature) {
                      var icon = controller.session.appIcons?.firstWhereOrNull(
                        (icon) => icon.id == feature.name,
                      );
                      var idx = Features.values.indexOf(feature);
                      var name = idx == 0
                          ? "Date"
                          : idx == 1
                              ? "Location"
                              : idx == 2
                                  ? "Printer"
                                  : idx == 3
                                      ? "Data Sync"
                                      : "";
                      return FeatureComponent(
                        image:
                            icon?.icon != null && icon?.icon?.isNotEmpty == true
                                ? icon?.icon
                                : feature.icon,
                        name: name,
                        color: icon?.color,
                        width: icon?.size,
                        height: icon?.size,
                      );
                    },
                  ).toList(),
                ).paddings(vertical: 12),
              ),
            ),
          ),
          SliverAnimatedGrid(
            initialItemCount: CreditOrderHistoryTypes.values.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1 / 1,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2),
            itemBuilder: (context, index, animation) {
              var type = CreditOrderHistoryTypes.values[index];

              return ServiceContainer(
                name: type.text,
                image: type.image,
                animation: animation.value,
                onClick: () => controller.onTapCreditHistory(type),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<CreditSalesOrderController>();
    super.dispose();
  }
}
