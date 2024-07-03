import 'package:flutter/material.dart';
import 'package:suhol_van_sales/app/theme/images.dart';

enum ServiceOne {
  cashSales(Images.moneyStackSVG, "CASH SALES"),
  creditSales(Images.creditCardSVG, "CREDIT SALES"),
  preOrder(Images.orderApprovedSVG, "PRE ORDER"),
  remotePrint(Images.mobilePrintSVG, "REMOTE PRINT"),
  stocks(Images.packageSVG, "STOCKS"),
  collection(Images.collectionSVG, "COLLECTION"),
  purchaseOrder(Images.purchaseSVG, "PURCHASE ORDER"),
  myOrder(Images.moneyHandSVG, "MR ORDER"),
  allService(Icons.more_horiz, "All Services");

  final dynamic image;
  final String name;

  const ServiceOne(this.image, this.name);
}
