import 'package:suhol_van_sales/app/theme/images.dart';

enum CreditOrderHistoryTypes {
  creditSalesOrder(Images.creditSalesOrder, "Credit\nSales Order"),
  creditSalesOrderList(Images.creditSalesOrderList, "Credit\nSales Order List"),
  creditApprovedOrder(Images.creditApproved, "Credit S Order Approved"),
  creditSalesReturn(Images.walletSVG, "Credit\nSales Return"),
  customerMiniStatement(Images.walletSVG, "Customer\nMini Statement"),
  billToBilCash(Images.walletSVG, "Bill to Bill\nCash Collection");

  final dynamic image;
  final String name;
  const CreditOrderHistoryTypes(this.image, this.name);
}
