import 'package:suhol_van_sales/app/theme/images.dart';

enum CashOrderHistoryTypes {
  cashSalesOrder(Images.creditSalesOrder, "Cash Sales Order"),
  cashSalesOrderList(Images.creditSalesOrderList, "Cash\nSales Order List"),
  cashApprovedOrder(Images.creditApproved, "Cash S.Order Approved");

  final dynamic image;
  final String name;

  const CashOrderHistoryTypes(this.image, this.name);
}
