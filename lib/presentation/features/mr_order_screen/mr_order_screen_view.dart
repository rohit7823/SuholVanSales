import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/presentation/utils/extensions.dart';
import 'package:suhol_van_sales/presentation/utils/mrorder_types.dart';

import '../../utils/features.dart';
import '../../widgets/feature_component.dart';
import '../../widgets/service_container.dart';
import 'mr_order_screen_controller.dart';

class MrOrderScreen extends StatefulWidget {
  const MrOrderScreen({super.key});

  @override
  State<MrOrderScreen> createState() => _MrOrderScreenState();
}

class _MrOrderScreenState extends State<MrOrderScreen> {
  final controller = Get.find<MrOrderScreenController>();

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
                        onClick: controller.onClickFeature,
                      );
                    },
                  ).toList(),
                ).paddings(vertical: 12),
              ),
            ),
          ),
          SliverAnimatedGrid(
            initialItemCount: MrOrderTypes.values.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1 / 1,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2),
            itemBuilder: (context, index, animation) {
              var type = MrOrderTypes.values[index];
              var icon = controller.session.appIcons?.firstWhereOrNull(
                (icon) => icon.id == type.name,
              );
              return ServiceContainer(
                name: type.text,
                image: icon != null && icon.icon?.isNotEmpty == true
                    ? icon.icon
                    : type.image,
                animation: animation.value,
                onClick: () => controller.onTapMROrder(type),
                color: icon?.color,
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<MrOrderScreenController>();
    super.dispose();
  }
}
