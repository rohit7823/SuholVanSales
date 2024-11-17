import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/presentation/utils/extensions.dart';

class FeatureComponent extends StatelessWidget {
  const FeatureComponent(
      {super.key,
      required this.image,
      required this.name,
      this.onClick,
      this.color,
      this.width,
      this.height});

  final String? image;
  final String? color;
  final String name;
  final double? width;
  final double? height;
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
                          width: width,
                          height: height,
                        )
                      : Image.network(
                          image!,
                          color: color?.toColor,
                          width: width,
                          height: height,
                        )
                  : image!.endsWith(".svg")
                      ? SvgPicture.asset(
                          image!,
                          color: color?.toColor,
                          width: width,
                          height: height,
                        )
                      : Image.asset(
                          image!,
                          color: color?.toColor,
                          width: width,
                          height: height,
                        )
              : const SizedBox.shrink(),
          Text(
            name,
            style: Get.textTheme.labelSmall?.copyWith(color: Colors.grey),
          )
        ],
      ),
    );
  }
}
