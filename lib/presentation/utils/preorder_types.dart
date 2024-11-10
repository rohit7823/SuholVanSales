import 'package:suhol_van_sales/app/theme/images.dart';

enum PreOrderTypes {
  preCreate(Images.creditSalesOrder, "Preorder Create"),
  preOrders(Images.creditSalesOrderList, "Preorder List"),
  preApprovedOrders(Images.creditApproved, "Preorder Approved");

  final dynamic image;
  final String text;

  const PreOrderTypes(this.image, this.text);
}
