import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/app/theme/fonts.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {super.key,
      this.hint,
      required this.controller,
      this.inputFormatters,
      this.keyboardType,
      this.onChanged,
      this.onSubmitted,
      this.capitalization,
      this.inputAction,
      this.autoFocus = true,
      this.width,
      this.isReadOnly});

  final String? hint;

  final bool? autoFocus;

  final TextEditingController controller;

  final List<TextInputFormatter>? inputFormatters;

  final TextInputType? keyboardType;

  final void Function(String? input)? onChanged;

  final void Function(String? value)? onSubmitted;

  final TextCapitalization? capitalization;

  final TextInputAction? inputAction;

  final double? width;

  final bool? isReadOnly;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Get.textTheme.titleLarge
          ?.copyWith(color: Colors.black, fontFamily: Fonts.dmSansSemiBold),
      enableSuggestions: true,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.lightBlueAccent)),
          constraints: BoxConstraints.expand(
              width: width ?? Get.width * .90, height: 45),
          fillColor: Colors.white,
          filled: true,
          hintText: hint,
          hintStyle: Get.textTheme.titleLarge?.copyWith(
              color: Colors.grey.shade400, fontFamily: Fonts.dmSansSemiBold),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.lightBlueAccent))),
      cursorColor: Colors.black,
      autocorrect: true,
      autofocus: autoFocus ?? false,
      controller: controller,
      canRequestFocus: autoFocus ?? false,
      inputFormatters: inputFormatters,
      scrollPhysics: const BouncingScrollPhysics(),
      keyboardType: keyboardType,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textCapitalization: capitalization ?? TextCapitalization.none,
      textInputAction: inputAction,
      readOnly: isReadOnly ?? false,
    );
  }
}
