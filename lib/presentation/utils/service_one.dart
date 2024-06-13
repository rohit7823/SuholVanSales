import 'package:flutter/material.dart';
import 'package:suhol_van_sales/app/theme/images.dart';

enum ServiceOne {
  cashSales(Images.cashSales, "CASH SALES"),
  creditSales(Images.creditSales, "CREDIT SALES"),
  preOrder(Images.preOrder, "PRE ORDER"),
  remotePrint(Images.remotePrint, "REMOTE PRINT"),
  stocks(Images.stocks, "STOCKS"),
  collection(Images.collection, "COLLECTION"),
  purchaseOrder(Images.purchaseOrder, "PURCHASE ORDER"),
  myOrder(Images.myOrder, "MR ORDER"),
  allService(Icons.more_horiz, "All Services");

  final dynamic image;
  final String name;

  const ServiceOne(this.image, this.name);
}
