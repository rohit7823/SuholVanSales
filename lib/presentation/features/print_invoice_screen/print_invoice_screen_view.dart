import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/app/theme/colors.dart';
import 'package:suhol_van_sales/presentation/widgets/invoice_widget.dart';
import 'package:suhol_van_sales/presentation/widgets/my_app_bar.dart';

import 'print_invoice_screen_controller.dart';

class PrintInvoiceScreen extends StatefulWidget {
  const PrintInvoiceScreen({super.key});

  @override
  State<PrintInvoiceScreen> createState() => _PrintInvoiceScreenState();
}

class _PrintInvoiceScreenState extends State<PrintInvoiceScreen> {
  final controller = Get.find<PrintInvoiceScreenController>();
  final invoiceKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        isTitleCenter: true,
        title: Obx(() => controller.selectedDevice.value == null
            ? Text(
                "Select your device",
                style: Get.textTheme.headlineMedium,
              )
            : Text(
                "${controller.selectedDevice.value?.name ?? controller.selectedDevice.value?.address}",
                style: Get.textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              )),
      ),
      floatingActionButton: Obx(() => FloatingActionButton.extended(
            onPressed: controller.invoiceData.value != null
                ? () => controller.selectedDevice.value != null
                    ? controller.print(invoiceKey)
                    : controller.selectDevice()
                : null,
            backgroundColor: AppColors.buttonColor,
            label: Text(
              controller.selectedDevice.value != null
                  ? "Print Invoice"
                  : "Select Printer",
              style: Get.textTheme.labelLarge!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            icon: Icon(
              controller.selectedDevice.value != null
                  ? Icons.print
                  : Icons.bluetooth_audio_outlined,
              color: Colors.white,
              size: 30,
            ),
          )),
      body: Center(
        child: ObxValue(
            (invoiceData) => invoiceData.value != null
                ? InvoiceWidget(
                    gKey: invoiceKey,
                    data: invoiceData.value!,
                  )
                : const SizedBox.shrink(),
            controller.invoiceData),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<PrintInvoiceScreenController>();
    super.dispose();
  }
}
