import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/presentation/utils/cash_order_history_types.dart';
import 'package:suhol_van_sales/presentation/utils/extensions.dart';
import 'package:suhol_van_sales/presentation/widgets/feature_component.dart';
import 'package:suhol_van_sales/presentation/widgets/service_container.dart';

import '../../utils/features.dart';
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
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 8),
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
            initialItemCount: CashOrderHistoryTypes.values.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1 / 1,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2),
            itemBuilder: (context, index, animation) {
              var type = CashOrderHistoryTypes.values[index];
              var icon = controller.session.appIcons?.firstWhereOrNull(
                (icon) => icon.id == type.name,
              );

              return ServiceContainer(
                name: type.name,
                image: icon != null && icon.icon?.isNotEmpty == true
                    ? icon.icon
                    : type.image,
                color: icon?.color,
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
