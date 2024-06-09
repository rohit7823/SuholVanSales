import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar(
      {super.key,
      this.onPop,
      this.isPop = false,
      this.bgColor = Colors.white,
      this.title,
      this.actions = const [],
      this.isTitleCenter = true,
      this.leading,
      this.icon});
  final Function? onPop;
  final bool isPop;
  final Color bgColor;
  final Widget? title;
  final List<Widget> actions;
  final Widget? leading;
  final bool isTitleCenter;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: bgColor,
      leading: isPop
          ? NavigateBack(
              onPop: onPop,
              icon: icon,
            )
          : leading ?? const SizedBox.shrink(),
      title: title,
      centerTitle: isTitleCenter,
      actions: actions,
      leadingWidth: 30,
      titleSpacing: 0,
    );
  }

  @override
  Size get preferredSize => Size(Get.width, Get.width * .16);
}

class NavigateBack extends StatelessWidget {
  final Function? onPop;
  final IconData? icon;

  const NavigateBack({super.key, this.onPop, this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onPop != null) {
          onPop?.call();
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Icon(icon ?? Icons.arrow_back, size: 20, color: Colors.black54),
    );
  }
}
