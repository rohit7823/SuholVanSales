import 'dart:developer';

import 'package:esc_pos_bluetooth_updated/esc_pos_bluetooth_updated.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/app/theme/colors.dart';
import 'package:suhol_van_sales/app/theme/fonts.dart';
import 'package:suhol_van_sales/presentation/widgets/animated_progress.dart';
import 'package:suhol_van_sales/printer/bluetooh_utills.dart';
import 'package:suhol_van_sales/printer/exts.dart';
import 'package:suhol_van_sales/printer/printer_utils.dart';

class PairedDevicesPopup {
  PairedDevicesPopup._();

  static PairedDevicesPopup? _instance;

  factory PairedDevicesPopup.getInstance() {
    _instance ??= PairedDevicesPopup._();
    return _instance!;
  }

  Future<void> show(
      {required GenericPrinter printer,
      required void Function(PrinterBluetooth device) onDeviceConnect,
      required Rx<PrinterBluetooth?> selectedDevice,
      void Function()? onPrint,
      Stream<PosPrintResult?>? printStatus}) async {
    var isGranted = await BluetoohUtills.instance.isPermissionGranted;
    log("$isGranted", name: "BLUETOOTH_PERMISSION");
    if (isGranted) {
      var isBluetoothConnected =
          await BluetoohUtills.instance.isBluetoothEnabled;
      debugPrint("isBluetoothConnected $isBluetoothConnected");
      if (isBluetoothConnected) {
        try {
          Get.dialog(AlertDialog(
            title: const Text("Paired Devices"),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            insetPadding: const EdgeInsets.symmetric(horizontal: 12),
            content: StreamBuilder(
              stream: printer.devices,
              builder: (context, printers) => Column(
                mainAxisSize: MainAxisSize.min,
                children: printers.data?.isNotEmpty == true
                    ? printers.data?.map(
                          (d) {
                            var device = d.convert;
                            return InkWell(
                              onTap: () => onDeviceConnect(device),
                              child: Column(
                                children: [
                                  Card(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    color: device == selectedDevice.value
                                        ? AppColors.buttonColorAlternate
                                        : Colors.white,
                                    elevation: 5,
                                    child: SizedBox(
                                      width: Get.width * .85,
                                      height: 45,
                                      child: Center(
                                        child: Text(
                                          "${device.name}",
                                          style: Get
                                              .textTheme.labelLarge
                                              ?.copyWith(
                                                  fontFamily: device ==
                                                          selectedDevice.value
                                                      ? Fonts.dmSansBold
                                                      : Fonts.dmSansSemiBold,
                                                  color: device ==
                                                          selectedDevice.value
                                                      ? Colors.white
                                                      : Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Obx(() => device == selectedDevice.value
                                      ? InkWell(
                                          onTap: onPrint,
                                          child: StreamBuilder(
                                            stream: printStatus,
                                            builder:
                                                (context, printingStatus) =>
                                                    Card(
                                              margin: const EdgeInsets.only(
                                                  bottom: 8),
                                              color:
                                                  device == selectedDevice.value
                                                      ? AppColors.buttonColor
                                                      : Colors.white,
                                              elevation: 5,
                                              child: SizedBox(
                                                width: Get.width * .55,
                                                height: 35,
                                                child: Center(
                                                  child: Text(
                                                    printingStatus.data?.msg ??
                                                        'PRINT SAMPLE',
                                                    style: Get
                                                        .textTheme.titleMedium
                                                        ?.copyWith(
                                                            fontFamily: device ==
                                                                    selectedDevice
                                                                        .value
                                                                ? Fonts
                                                                    .dmSansBold
                                                                : Fonts
                                                                    .dmSansSemiBold,
                                                            color: device ==
                                                                    selectedDevice
                                                                        .value
                                                                ? Colors.white
                                                                : Colors.black),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink())
                                ],
                              ),
                            );
                          },
                        ).toList() ??
                        []
                    : [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Getting Devices...",
                              style: Get.textTheme.titleMedium,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.redAccent,
                                strokeCap: StrokeCap.round,
                              ),
                            )
                          ],
                        )
                      ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (Get.overlayContext != null) {
                      Navigator.of(Get.overlayContext!).pop();
                    }
                  },
                  child: Text(
                    "CLOSE",
                    style: Get.textTheme.bodyMedium?.copyWith(
                        fontFamily: Fonts.poppinsBold, color: Colors.redAccent),
                  )),
            ],
            actionsAlignment: MainAxisAlignment.center,
          ));
        } on Object catch (ex) {
          Get.showSnackbar(GetSnackBar(
            message: ex.toString(),
            duration: const Duration(seconds: 5),
          ));
        } finally {
          AnimatedProgress.closeProgressIfShowing();
        }
      } else {
        Get.showSnackbar(const GetSnackBar(
          message: "Need to connect with bluetooth first.",
          duration: Duration(seconds: 5),
        ));
      }
    } else {
      Get.defaultDialog(
        content: Text(
          "Need to give bluetooth permission manually for accessing available devices",
          style: Get.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        textCancel: "No",
        textConfirm: "Ok",
        onCancel: () {
          if (Get.overlayContext != null) {
            Navigator.of(Get.overlayContext!).pop();
          }
        },
        onConfirm: () async {
          if (Get.overlayContext != null) {
            Navigator.of(Get.overlayContext!).pop();
          }
          await BluetoohUtills.instance.openBluetoothSettings().then(
                (value) => show(
                    onDeviceConnect: onDeviceConnect,
                    onPrint: onPrint,
                    printer: printer,
                    selectedDevice: selectedDevice,
                    printStatus: printStatus),
              );
        },
      );
    }
  }
}
