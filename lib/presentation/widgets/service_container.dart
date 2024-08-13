import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/app/theme/colors.dart';
import 'package:suhol_van_sales/presentation/utils/extensions.dart';

class ServiceContainer extends StatelessWidget {
  const ServiceContainer(
      {super.key,
      this.animation,
      this.onClick,
      this.image,
      this.color,
      required this.name});

  final double? animation;
  final void Function()? onClick;
  final dynamic image;
  final String? color;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onClick,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            image is String
                ? (image as String).isURL
                    ? image.endsWith(".svg")
                        ? SvgPicture.network(
                            image,
                            width: 35,
                            height: 35,
                            color: color?.toColor,
                          )
                        : Image.network(
                            image,
                            width: 35,
                            height: 35,
                            color: color?.toColor,
                          )
                    : image.endsWith(".svg")
                        ? SvgPicture.asset(
                            image,
                            width: 35,
                            height: 35,
                            color: color?.toColor,
                          )
                        : Image.asset(
                            image,
                            width: 35,
                            height: 35,
                            color: color?.toColor,
                          )
                : Icon(
                    image,
                    size: 35,
                  ),
            Text(
              name,
              style: Get.textTheme.titleMedium?.copyWith(color: Colors.black),
              textAlign: TextAlign.center,
            ).paddings(horizontal: 3)
          ],
        ),
      ),
    );
  }
}
