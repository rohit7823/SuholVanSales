import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:suhol_van_sales/domain/data_source/remote/material_request/request/material_requisition_request.dart';
import 'package:suhol_van_sales/presentation/utils/extensions.dart';

class InvoiceWidget extends StatefulWidget {
  const InvoiceWidget({required this.gKey, required this.data});

  final GlobalKey gKey;
  final MaterialRequisitionRequest data;

  @override
  State<InvoiceWidget> createState() => _InvoiceWidgetState();
}

class _InvoiceWidgetState extends State<InvoiceWidget> {
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: widget.gKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Column(
                children: [
                  Text(
                    "K C CENTRE L.L.C",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "C.R. 1144942, PO Box 3347, PC 111, Seeb CPO",
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Central Vegetable Market, Al Mawaleh",
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Muscat, Sultanate of Oman, Ph: 91308594",
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "CASH BILL",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              color: Colors.black,
            ),
            const SizedBox(height: 8),
            const Text("Customer: AL THIMAR UNITED BUSINESS PROJECTS"),
            Text("Phone: ${widget.data.phoneNo}"),
            const SizedBox(height: 8),
            Text(
                "Delivery Date: ${(widget.data.deliveryDate ?? DateTime.now()).formattedDateWithTime(widget.data.deliveryTime)}"),
            const Divider(
              thickness: 1,
              color: Colors.black,
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Text("No"),
                SizedBox(
                  width: 18,
                ),
                Expanded(flex: 7, child: Text("Item")),
                Expanded(
                    flex: 2,
                    child: Text(
                      "Qty",
                      textAlign: TextAlign.center,
                    )),
                Expanded(
                  flex: 3,
                  child: Text(
                    "Price",
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Text(
                      "Remarks",
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
            const Divider(
              thickness: 1,
              color: Colors.black,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text("01"),
                const SizedBox(
                  width: 18,
                ),
                Flexible(
                    flex: 7,
                    child: Text(
                        "${widget.data.productName} - ${widget.data.productUnit} | ${widget.data.productPacking}")),
                Expanded(
                    flex: 2,
                    child: Text(
                      "${widget.data.quantity}",
                      textAlign: TextAlign.center,
                    )),
                Expanded(
                  flex: 3,
                  child: Text(
                    NumberFormat.currency(decimalDigits: 2, symbol: '₹')
                        .format(widget.data.price ?? 0.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Text(
                      widget.data.remarks ?? 'NIL',
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
            /*const Column(
              children: [
                Row(
                  children: [
                    Expanded(flex: 3, child: Text("01")),
                    Expanded(
                        flex: 7, child: Text("Apple Green New Z Land - 135 P")),
                    Expanded(flex: 2, child: Text("5")),
                    Expanded(flex: 3, child: Text("0.000")),
                    Expanded(flex: 2, child: Text("0.000")),
                    Expanded(flex: 3, child: Text("0.000")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(flex: 3, child: Text("02")),
                    Expanded(
                        flex: 7,
                        child: Text("Banana Plantain Yellow IND - Medium")),
                    Expanded(flex: 2, child: Text("1")),
                    Expanded(flex: 3, child: Text("8.300")),
                    Expanded(flex: 2, child: Text("0.000")),
                    Expanded(flex: 3, child: Text("8.300")),
                  ],
                ),
              ],
            ),*/
            const Divider(
              thickness: 1,
              color: Colors.black,
            ),
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  const Text("C F I 23"),
                  const SizedBox(height: 8),
                  Container(
                    width: 150,
                    height: 2,
                    color: Colors.black,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
