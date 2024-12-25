import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:esc_pos_bluetooth_updated/esc_pos_bluetooth_updated.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bluetooth_basic_updated/flutter_bluetooth_basic.dart';
import 'package:get/get.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

extension PrinterBluetoothExts on BluetoothInfo {
  PrinterBluetooth get convert => PrinterBluetooth(BluetoothDevice.fromJson(
      {'name': name, 'address': macAdress, 'type': 0, 'connected': false}));
}

Future<ByteData?> captureImage(GlobalKey globalKey) async {
  RenderRepaintBoundary? boundary =
      globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

  // Screen DPI (Dots Per Inch)
  double dpi = 226 *
      Get.mediaQuery
          .devicePixelRatio; // Assuming base 160 DPI (standard Android)

  // Paper width in mm
  double paperWidthInMM = 88.0;

  // Convert mm to inches
  double paperWidthInInches = paperWidthInMM / 26.8;

  double screenWidthInPixels = Get.size.width * Get.mediaQuery.devicePixelRatio;

  // Calculate width in device pixels
  double paperWidthInPixels = paperWidthInInches * dpi;

  final ui.Image? image = await boundary?.toImage(
      pixelRatio: paperWidthInPixels / screenWidthInPixels);

  final ByteData? byteData =
      await image?.toByteData(format: ui.ImageByteFormat.png);

  return byteData;
}
