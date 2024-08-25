import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/app/theme/fonts.dart';

class AppTextField<T extends Object> extends StatelessWidget {
  static BoxConstraints fixedBoxConstraints() =>
      const BoxConstraints(maxHeight: kMinInteractiveDimension * 5);

  const AppTextField(
      {super.key,
      this.hint,
      this.controller,
      this.inputFormatters,
      this.keyboardType,
      this.onChanged,
      this.onSubmitted,
      this.capitalization,
      this.inputAction,
      this.autoFocus = false,
      this.width,
      this.isReadOnly,
      this.changeStyle = false,
      this.enabled = true,
      this.textAlign,
      this.error,
      this.labelStyle,
      this.label,
      this.isObscure = false,
      this.borderColor,
      this.suffixIcon,
      this.isFullScreen = false,
      this.fieldType = FieldType.normal,
      this.suggestionsBuilder,
      this.suggestionDisplayOption,
      this.textFieldDisplayOption,
      this.onSelectResult,
      this.suggestionConstraints,
      this.searchController,
      this.viewBuilder,
      this.focusNode,
      this.prefixIcon,
      this.onTap});

  final FieldType fieldType;

  final String? hint;

  final bool? autoFocus;

  final TextEditingController? controller;

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

  final Widget? suffixIcon;

  final Widget? prefixIcon;

  final FutureOr<Iterable<T>> Function(SearchController searchController)?
      suggestionsBuilder;

  final String Function(T)? suggestionDisplayOption;

  final String Function()? textFieldDisplayOption;

  final void Function(T result, SearchController controller)? onSelectResult;

  final BoxConstraints? suggestionConstraints;

  final SearchController? searchController;

  final Widget Function(Iterable<Widget> widgets)? viewBuilder;

  final bool isFullScreen;

  final FocusNode? focusNode;

  final void Function(FocusNode? focusNode)? onTap;

  @override
  Widget build(BuildContext context) {
    return fieldType == FieldType.autocomplete
        ? SearchAnchor(
            builder: (BuildContext context, SearchController controller) =>
                MyTextField(
              controller: controller,
              changeStyle: changeStyle,
              enabled: enabled,
              isObscure: isObscure,
              width: width,
              autoFocus: autoFocus,
              borderColor: borderColor,
              capitalization: capitalization,
              error: error,
              hint: hint,
              inputAction: inputAction,
              inputFormatters: inputFormatters,
              isReadOnly: isReadOnly,
              onTap: (focusNode) => searchController?.openView(),
              keyboardType: keyboardType,
              label: label,
              labelStyle: labelStyle,
              suffixIcon: suffixIcon,
              textAlign: textAlign,
              focusNode: focusNode,
              prefixIcon: prefixIcon,
            ),
            isFullScreen: isFullScreen,
            suggestionsBuilder:
                (BuildContext context, SearchController controller) async {
              var values = await suggestionsBuilder?.call(controller);

              return values!
                  .mapIndexed((idx, item) => CustomAutocompleteOption(
                        displayStringForOption: suggestionDisplayOption!,
                        onSelected: (option) {
                          controller.closeView("");
                          FocusManager.instance.primaryFocus?.unfocus();
                          onSelectResult?.call(option, controller);
                        },
                        option: item,
                        index: idx,
                      ))
                  .toList();
            },
            viewConstraints: suggestionConstraints ??
                BoxConstraints(
                    maxWidth: context.width,
                    maxHeight: kMinInteractiveDimension * 5),
            dividerColor: Colors.grey,
            viewHintText: hint,
            headerHintStyle: Get.textTheme.titleLarge?.copyWith(
                color: Colors.grey.shade500, fontFamily: Fonts.dmSansSemiBold),
            viewBuilder: viewBuilder,
            searchController: searchController,
            headerTextStyle: Get.textTheme.titleLarge?.copyWith(
                color: Colors.black, fontFamily: Fonts.dmSansSemiBold),
            viewTrailing: [
              IconButton(
                  onPressed: () {
                    searchController?.closeView("");
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.grey,
                  ))
            ],
            keyboardType: keyboardType,
            textInputAction: inputAction,
            textCapitalization: capitalization,
            viewShape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            viewLeading: const SizedBox.shrink(),
            viewBackgroundColor: Colors.white,
            viewSurfaceTintColor: Colors.white,
            headerHeight: 40,
          )
        : MyTextField(
            controller: textFieldDisplayOption != null
                ? TextEditingController(text: textFieldDisplayOption?.call())
                : controller,
            changeStyle: changeStyle,
            enabled: enabled,
            isObscure: isObscure,
            width: width,
            autoFocus: autoFocus,
            borderColor: borderColor,
            capitalization: capitalization,
            error: error,
            hint: hint,
            inputAction: inputAction,
            inputFormatters: inputFormatters,
            isReadOnly: isReadOnly,
            keyboardType: keyboardType,
            label: label,
            labelStyle: labelStyle,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            suffixIcon: suffixIcon,
            textAlign: textAlign,
            focusNode: focusNode,
            prefixIcon: prefixIcon,
            onTap: onTap,
          );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField(
      {super.key,
      this.hint,
      this.autoFocus,
      this.controller,
      this.inputFormatters,
      this.keyboardType,
      this.onChanged,
      this.onSubmitted,
      this.capitalization,
      this.inputAction,
      this.width,
      this.isReadOnly,
      required this.changeStyle,
      required this.enabled,
      this.textAlign,
      this.error,
      this.labelStyle,
      this.label,
      required this.isObscure,
      this.borderColor,
      this.suffixIcon,
      this.focusNode,
      this.onTap,
      this.prefixIcon});

  final String? hint;

  final bool? autoFocus;

  final TextEditingController? controller;

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

  final Widget? suffixIcon;

  final Widget? prefixIcon;

  final FocusNode? focusNode;

  final void Function(FocusNode? focusNode)? onTap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Get.textTheme.titleMedium
          ?.copyWith(color: Colors.black, fontFamily: Fonts.dmSansSemiBold),
      focusNode: focusNode,
      enableSuggestions: true,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
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
              width: width ?? Get.width * .90, height: 45),
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
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon),
      onTap: onTap != null
          ? () {
              onTap?.call(focusNode);
            }
          : null,
      cursorColor: Colors.lightBlueAccent,
      autocorrect: true,
      autofocus: autoFocus ?? false,
      controller: controller,
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

enum FieldType {
  normal("normal"),
  autocomplete("autocomplete");

  final String key;

  const FieldType(this.key);
}

class CustomAutocompleteOption<T extends Object> extends StatefulWidget {
  const CustomAutocompleteOption(
      {super.key,
      required this.displayStringForOption,
      required this.onSelected,
      required this.option,
      required this.index});

  final AutocompleteOptionToString<T> displayStringForOption;

  final AutocompleteOnSelected<T> onSelected;

  final T option;

  final int index;

  @override
  State<CustomAutocompleteOption<T>> createState() =>
      _CustomAutocompleteOptionState<T>();
}

class _CustomAutocompleteOptionState<T extends Object>
    extends State<CustomAutocompleteOption<T>> {
  bool isDisfunct = false;
  RxBool highlight = RxBool(false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    highlight.value = AutocompleteHighlightedOption.of(context) == widget.index;
    if (highlight.value) {
      SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
        try {
          if (!isDisfunct) {
            Scrollable.ensureVisible(context, alignment: 0.5);
          }
        } on Exception catch (ex) {}
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 4.0,
        child: InkWell(
          onTap: () {
            widget.onSelected(widget.option);
          },
          child: Container(
            width: context.width,
            padding: const EdgeInsets.all(7.0),
            decoration: BoxDecoration(
                color: highlight.value ? Theme.of(context).focusColor : null,
                border: const Border(bottom: BorderSide(color: Colors.grey))),
            child: Text(
              widget.displayStringForOption(widget.option),
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    isDisfunct = true;
    super.dispose();
  }
}
