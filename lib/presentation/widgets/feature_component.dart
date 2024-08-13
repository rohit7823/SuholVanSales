import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/domain/di/session_service.dart';
import 'package:suhol_van_sales/presentation/utils/extensions.dart';

class FeatureComponent extends StatelessWidget {
  const FeatureComponent(
      {super.key,
      required this.image,
      required this.name,
      this.onClick,
      this.color});

  final String? image;
  final String? color;
  final String name;
  final void Function(String componentName)? onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick != null ? () => onClick?.call(name) : null,
      child: Column(
        children: [
          image != null
              ? image!.isURL
                  ? image!.endsWith(".svg")
                      ? SvgPicture.network(
                          image!,
                          color: color?.toColor,
                        )
                      : Image.network(image!, color: color?.toColor,)
                  : image!.endsWith(".svg")
                      ? SvgPicture.asset(image!, color: color?.toColor,)
                      : Image.asset(image!, color: color?.toColor,)
              : const SizedBox.shrink(),
          const SizedBox(
            height: 12,
          ),
          Text(
            name,
            style: Get.textTheme.labelSmall?.copyWith(color: Colors.grey),
          )
        ],
      ),
    );
  }
}
