import 'package:get/get.dart';

import 'print_invoice_screen_controller.dart';

class PrintInvoiceScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PrintInvoiceScreenController());
  }
}
