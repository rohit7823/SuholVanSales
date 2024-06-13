import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceContainer extends StatelessWidget {
  const ServiceContainer(
      {super.key,
      this.animation,
      this.onClick,
      this.image,
      required this.name});

  final double? animation;
  final void Function()? onClick;
  final dynamic image;
  final String name;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: animation,
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: onClick,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            image is String
                ? Image.asset(
                    image,
                    width: 45,
                  )
                : Icon(
                    image,
                    size: 45,
                  ),
            Text(
              name,
              style: Get.textTheme.titleMedium?.copyWith(color: Colors.black),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
