import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suhol_van_sales/domain/data_source/remote/approved_orders/response/approved_orders_response.dart';
import 'package:suhol_van_sales/presentation/utils/extensions.dart';
import 'package:suhol_van_sales/presentation/widgets/my_app_bar.dart';

import 'approved_orders_logic.dart';

class ApprovedOrdersScreen extends StatefulWidget {
  const ApprovedOrdersScreen({super.key});

  @override
  State<ApprovedOrdersScreen> createState() => _ApprovedOrdersScreenState();
}

class _ApprovedOrdersScreenState extends State<ApprovedOrdersScreen> {
  final ApprovedOrdersController controller =
      Get.find<ApprovedOrdersController>();

  final List<Order> cashSales = const [
    Order(
      customerName: 'John Doe',
      mobileNumber: '9876543210',
      productName: 'Product A',
      productPacking: 'Box',
      productUnit: 'Kg',
      productQuantity: '10',
      price: '100.0',
    ),
  ];

  @override
  void dispose() {
    Get.delete<ApprovedOrdersController>();
    super.dispose();
  }

  final List<Order> creditSales = const [
    Order(
      customerName: 'Jane Smith',
      mobileNumber: '9123456780',
      productName: 'Product B',
      productPacking: 'Packet',
      productUnit: 'Litre',
      productQuantity: '5',
      price: '50.0',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        leading: InkWell(
            onTap: controller.pop,
            child: const Icon(
              Icons.arrow_back_sharp,
              color: Colors.white,
            )).paddings(left: 8),
        title: Obx(
          () => Text(controller.orderType.value == OrderType.cashSalesOrder
              ? "💵 Cash Sale Orders"
              : "💳 Credit Sale Order"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Obx(
          () => controller.orderType.value == OrderType.cashSalesOrder
              ? controller.cashSales.isNotEmpty
                  ? ListView.separated(
                      itemCount: controller.cashSales.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 12,
                      ),
                      itemBuilder: (context, index) =>
                          _buildCategory('', controller.cashSales[index]),
                    )
                  : Center(
                      child: Text(
                        'No Approved Orders, yet.',
                        style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600, color: Colors.grey),
                      ),
                    )
              : controller.creditSales.isNotEmpty
                  ? ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 12,
                      ),
                      itemCount: controller.creditSales.length,
                      itemBuilder: (context, index) =>
                          _buildCategory('', controller.creditSales[index]),
                    )
                  : Center(
                      child: Text(
                        'No Approved Orders, yet.',
                        style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600, color: Colors.grey),
                      ),
                    ),
        ),
      ),
    );
  }

  Widget _buildCategory(String title, Order order) {
    return OrderTile(
            order:
                order) /* Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        ,
      ],
    )*/
        ;
  }
}

class OrderTile extends StatelessWidget {
  final Order order;

  const OrderTile({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _row("👤 Customer", order.customerName),
            _row("📞 Mobile", order.mobileNumber.isBlank == false ? order.mobileNumber : 'No Value'),
            const Divider(height: 20),
            _row("📦 Product", order.productName),
            const Divider(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("📦 Packing", style: _labelStyle)
                          .paddingOnly(right: 8),
                      Text(order.productPacking, style: _valueStyle),
                    ],
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("⚖️ Unit", style: _labelStyle).paddingOnly(right: 8),
                      Text(order.productUnit, style: _valueStyle),
                    ],
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("🔢 Qty", style: _labelStyle).paddingOnly(right: 8),
                      Text(order.productQuantity.toString(),
                          style: _valueStyle),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(height: 20),
            _row("💰 Price", "₹${order.price}"),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(width: 90, child: Text(label, style: _labelStyle)),
          Expanded(child: Text(value, style: _valueStyle)),
        ],
      ),
    );
  }

  TextStyle get _labelStyle => const TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      );

  TextStyle get _valueStyle => const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      );
}
