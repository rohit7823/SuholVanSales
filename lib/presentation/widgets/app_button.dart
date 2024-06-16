import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/app/theme/fonts.dart';
import 'package:suhol_van_sales/presentation/utils/extensions.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onClick;
  final bool enable;
  final bool showLoading;
  final Color loaderColor;
  final Widget? child;
  final String? label;
  final Color? labelColor;
  final Color? btnColor;
  final double? width;
  final double? height;
  final BorderSide? borderSide;
  final OutlinedBorder? border;

  const AppButton(
      {super.key,
      required this.onClick,
      this.enable = true,
      this.showLoading = false,
      this.width,
      this.label,
      this.child,
      this.loaderColor = Colors.white,
      this.labelColor,
      this.btnColor,
      this.height,
      this.borderSide,
      this.border});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enable
          ? () {
              if (showLoading) return;
              onClick();
            }
          : null,
      style: enable
          ? ButtonStyle(
                  fixedSize: WidgetStateProperty.all(
                      Size(width ?? context.width, height ?? 55)),
                  backgroundColor: WidgetStateProperty.all(Colors.black54),
                  elevation: const WidgetStatePropertyAll(7),
                  shape: WidgetStateProperty.all(border ??
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  side: borderSide != null
                      ? WidgetStateProperty.all(borderSide)
                      : null)
              .copyWith(
                  backgroundColor: WidgetStatePropertyAll(
                      btnColor ?? Get.theme.colorScheme.primary))
          : ButtonStyle(
              fixedSize: WidgetStateProperty.all(
                  Size(width ?? context.width, height ?? 55)),
              backgroundColor: WidgetStateProperty.all(const Color(0xFFA3A3A3)),
              elevation: const WidgetStatePropertyAll(7),
              shape: WidgetStateProperty.all(border ??
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)))),
      child: showLoading
          ? CircularProgressIndicator(
              color: Theme.of(context).colorScheme.background,
            )
          : child ??
              label
                  ?.text(labelColor != null
                      ? Theme.of(context).primaryTextTheme.labelLarge?.copyWith(
                          fontFamily: Fonts.dmSansSemiBold, color: labelColor)
                      : Theme.of(context)
                          .primaryTextTheme
                          .labelLarge
                          ?.copyWith(fontFamily: Fonts.dmSansSemiBold))
                  .fitBox(),
    );
  }
}
