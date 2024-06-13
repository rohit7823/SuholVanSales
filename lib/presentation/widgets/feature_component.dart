import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class FeatureComponent extends StatelessWidget {
  const FeatureComponent(
      {super.key, required this.image, required this.name, this.onClick});

  final String image;
  final String name;
  final void Function(String componentName)? onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick != null ? () => onClick?.call(name) : null,
      child: Column(
        children: [
          image.endsWith(".svg") ? SvgPicture.asset(image) : Image.asset(image),
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
