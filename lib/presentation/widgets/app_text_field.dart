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
      this.isReadOnly,
      this.changeStyle = false,
      this.enabled = true,
      this.textAlign,
      this.error,
      this.labelStyle,
      this.label,
      this.isObscure = false,
      this.borderColor});

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

  final bool changeStyle;

  final bool enabled;

  final TextAlign? textAlign;

  final String? error;

  final TextStyle? labelStyle;

  final String? label;

  final bool isObscure;

  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Get.textTheme.titleLarge
          ?.copyWith(color: Colors.black, fontFamily: Fonts.dmSansSemiBold),
      enableSuggestions: true,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          border: changeStyle
              ? UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      BorderSide(color: borderColor ?? Colors.lightBlueAccent))
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      BorderSide(color: borderColor ?? Colors.lightBlueAccent)),
          constraints: BoxConstraints.expand(
              width: width ?? Get.width * .90, height: 45),
          fillColor: Colors.white,
          filled: true,
          hintText: hint,
          errorText: error,
          errorStyle: Get.textTheme.titleLarge
              ?.copyWith(color: Colors.red, fontFamily: Fonts.dmSansSemiBold),
          hintStyle: Get.textTheme.titleLarge?.copyWith(
              color: Colors.grey.shade400, fontFamily: Fonts.dmSansSemiBold),
          labelStyle: labelStyle ??
              Get.textTheme.titleMedium?.copyWith(
                  color: borderColor ?? Colors.lightBlueAccent,
                  fontFamily: Fonts.poppinsSemiBold),
          labelText: label,
          enabledBorder: changeStyle
              ? UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      BorderSide(color: borderColor ?? Colors.lightBlueAccent))
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      BorderSide(color: borderColor ?? Colors.grey.shade200)),
          focusedBorder: changeStyle
              ? UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      BorderSide(color: borderColor ?? Colors.lightBlueAccent))
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      BorderSide(color: borderColor ?? Colors.lightBlueAccent)),
          errorBorder: changeStyle
              ? UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.redAccent))
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.redAccent))),
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
      enabled: enabled,
      enableIMEPersonalizedLearning: enabled,
      textAlign: textAlign ?? TextAlign.start,
      obscureText: isObscure,
    );
  }
}
