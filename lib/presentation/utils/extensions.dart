import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

extension DateTimeUtils on DateTime {
  String currentDate({String format = "dd-MM-y"}) {
    var date = this;
    var fomatter = DateFormat(
      format,
    );
    return fomatter.format(date);
  }
}

extension ExtsOnContext on BuildContext {
  bool get isKeyboardVisible => MediaQuery.of(this).viewInsets.bottom > 0;
}

extension FixedBoxShadow on Object {
  List<BoxShadow> allShadow({double radius = 8.0}) {
    return [
      BoxShadow(
        color: const Color(0xFFEFEFEF),
        blurRadius: radius, // soften the shadow
        spreadRadius: 0.0, //extend the shadow
        offset: const Offset(
          5.0, // Move to right 10  horizontally
          2.0, // Move to bottom 10 Vertically
        ),
      ),
      BoxShadow(
        color: const Color(0xFFEFEFEF),
        blurRadius: radius, // soften the shadow
        spreadRadius: 0.0, //extend the shadow
        offset: const Offset(
          -5.0, // Move to right 10  horizontally
          -2.0, // Move to bottom 10 Vertically
        ),
      ),
    ];
  }
}

extension MyText on String {
  Widget text(
      [TextStyle? textStyle, TextOverflow? textOverflow, TextAlign? align]) {
    return Text(
      this,
      style: textStyle,
      overflow: textOverflow,
      textAlign: align,
    );
  }

  bool get isPassword =>
      (length >= 8 && !(isAlphabetOnly || isNumericOnly || isBlank == true));
}

extension WidgetUitilities on Widget {
  Widget paddings({
    double all = 0.0,
    double horizontal = 0.0,
    double vertical = 0.0,
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    horizontal = horizontal == 0.0 ? all : horizontal;
    vertical = vertical == 0.0 ? all : vertical;
    left = left == 0.0 ? horizontal : left;
    right = right == 0.0 ? horizontal : right;
    top = top == 0.0 ? vertical : top;
    bottom = bottom == 0.0 ? vertical : bottom;
    return Padding(
      padding:
          EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
      child: this,
    );
  }

  Widget get faded => ShaderMask(
        shaderCallback: (Rect rect) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purple,
              Colors.transparent,
              Colors.transparent,
              Colors.purple
            ],
            stops: [
              0.0,
              0.1,
              0.9,
              1.0
            ], // 10% purple, 80% transparent, 10% purple
          ).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: this,
      );

  Widget get fadedH => ShaderMask(
        shaderCallback: (Rect rect) {
          return const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.purple,
              Colors.transparent,
              Colors.transparent,
              Colors.purple
            ],
            stops: [
              0.0,
              0.1,
              0.9,
              1.0
            ], // 10% purple, 80% transparent, 10% purple
          ).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: this,
      );

  Widget get noScrollGlow =>
      NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: this);

  Widget noScrollGlowEx(bool ret) =>
      NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return ret;
          },
          child: this);

  Widget colored(Color color, {Key? key}) {
    return ColoredBox(color: color);
  }

  Widget get wrapInCenter {
    return wrap.center;
  }

  Widget get wrap {
    return Wrap(
      children: [this],
    );
  }

  Widget get center {
    return Center(
      child: this,
    );
  }

  Widget fitBox({BoxFit fit = BoxFit.contain}) {
    return FittedBox(
      fit: fit,
      child: this,
    );
  }

  Widget expanded({required int flex}) {
    return Expanded(flex: flex, child: this);
  }

  SizedBox sized({double width = 0.0, double height = 0.0}) {
    return SizedBox(
      width: width,
      height: height,
      child: this,
    );
  }

  Widget align({Alignment alignment = Alignment.center}) {
    return Align(
      alignment: alignment,
      child: this,
    );
  }
}
