import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_tag_editor/tag_editor.dart';
import 'package:suhol_van_sales/app/theme/fonts.dart';

class MyTagEditor extends StatelessWidget {
  final bool changeStyle;

  const MyTagEditor(
      {super.key,
      this.changeStyle = false,
      required this.length,
      this.hintText,
      this.width,
      required this.tagBuilder,
      required this.tagChanged,
      this.controller,
      this.icon,
      this.delimiters,
      this.borderColor,
      this.hint,
      this.error,
      this.labelStyle,
      this.label,
      this.suffixIconWidget,
      this.prefixIconWidget,
      this.showAddButton = false,
      this.height,
      this.onAdd});

  final int length;
  final String? hintText;
  final double? width;
  final Widget Function(BuildContext context, int index) tagBuilder;
  final void Function(String value) tagChanged;
  final void Function(String value)? onAdd;
  final TextEditingController? controller;
  final IconData? icon;
  final List<String>? delimiters;
  final Color? borderColor;
  final String? hint;
  final String? error;
  final TextStyle? labelStyle;
  final String? label;
  final Widget? suffixIconWidget;
  final Widget? prefixIconWidget;
  final bool showAddButton;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return TagEditor(
      length: length,
      delimiters: delimiters ?? const [',', ' '],
      hasAddButton: showAddButton,
      inputDecoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0),
        border: changeStyle
            ? UnderlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(color: borderColor ?? Colors.lightBlueAccent))
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(color: borderColor ?? Colors.lightBlueAccent)),
        constraints: BoxConstraints.expand(
            width: width ?? Get.width * .90, height: height ?? 45),
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: hint,
        errorText: error,
        errorStyle: Get.textTheme.titleMedium
            ?.copyWith(color: Colors.red, fontFamily: Fonts.dmSansSemiBold),
        hintStyle: Get.textTheme.titleMedium?.copyWith(
            color: Colors.grey.shade400, fontFamily: Fonts.dmSansSemiBold),
        labelStyle: labelStyle ??
            Get.textTheme.titleSmall?.copyWith(
                color: borderColor ?? Colors.lightBlueAccent,
                fontFamily: Fonts.poppinsSemiBold),
        labelText: label,
        enabledBorder: changeStyle
            ? UnderlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(color: borderColor ?? Colors.lightBlueAccent),
              )
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(color: borderColor ?? Colors.grey.shade200)),
        focusedBorder: changeStyle
            ? UnderlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(color: borderColor ?? Colors.lightBlueAccent))
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(color: borderColor ?? Colors.lightBlueAccent)),
        errorBorder: changeStyle
            ? UnderlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.redAccent))
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.redAccent)),
        suffixIcon: suffixIconWidget,
        prefixIcon: prefixIconWidget,
      ),
      tagBuilder: tagBuilder,
      onTagChanged: tagChanged,
      controller: controller,
      icon: icon,
      textInputAction: TextInputAction.next,
      textStyle: Get.textTheme.titleMedium
          ?.copyWith(color: Colors.black, fontFamily: Fonts.dmSansSemiBold),
      keyboardType: TextInputType.streetAddress,
      onSubmitted: onAdd,
    );
  }
}
