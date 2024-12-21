import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:esc_pos_bluetooth_updated/esc_pos_bluetooth_updated.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bluetooth_basic_updated/flutter_bluetooth_basic.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

extension PrinterBluetoothExts on BluetoothInfo {
  PrinterBluetooth get convert => PrinterBluetooth(BluetoothDevice.fromJson(
      {'name': name, 'address': macAdress, 'type': 0, 'connected': false}));
}

Future<ByteData?> captureImage(GlobalKey globalKey) async {
  RenderRepaintBoundary? boundary =
      globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

  final ui.Image? image = await boundary?.toImage();

  final ByteData? byteData =
      await image?.toByteData(format: ui.ImageByteFormat.png);

  return byteData;
}
