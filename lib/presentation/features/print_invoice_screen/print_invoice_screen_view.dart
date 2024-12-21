import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/app/theme/colors.dart';

import 'print_invoice_screen_controller.dart';

class PrintInvoiceScreen extends StatefulWidget {
  const PrintInvoiceScreen({super.key});

  @override
  State<PrintInvoiceScreen> createState() => _PrintInvoiceScreenState();
}

class _PrintInvoiceScreenState extends State<PrintInvoiceScreen> {
  final PrintInvoiceScreenController controller = Get.find();

  final invoiceKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(() => FloatingActionButton(
            onPressed: controller.invoice.value != null
                ? () => controller.print(invoiceKey)
                : null,
            backgroundColor: AppColors.buttonColor,
            child: const Icon(
              Icons.print,
              color: Colors.white,
              size: 40,
            ),
          )),
      body: Center(
        child: Obx(() => controller.invoice.value != null
            ? RepaintBoundary(
                key: invoiceKey,
                child: Image.memory(
                  controller.invoice.value!.buffer.asUint8List(),
                  width: context.width,
                  fit: BoxFit.fill,
                  height: context.height,
                ),
              )
            : const Text("LOADING...")),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<PrintInvoiceScreenController>();
    super.dispose();
  }
}
