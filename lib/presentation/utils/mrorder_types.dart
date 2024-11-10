import 'package:suhol_van_sales/app/theme/images.dart';

enum MrOrderTypes {
  mrCreate(Images.creditSalesOrder, "MR Create"),
  mrOrders(Images.creditSalesOrderList, "MR List"),
  mrApproved(Images.creditApproved, "MR Approved");

  final dynamic image;
  final String text;
  const MrOrderTypes(this.image, this.text);
}
