import 'package:flutter/material.dart';
import 'package:suhol_van_sales/app/theme/images.dart';

enum ServiceOne {
  cashSales(Images.moneyStackSVG, "cashSales", "CASH SALES"),
  creditSales(Images.creditCardSVG, "creditSales", "CREDIT SALES"),
  preOrder(Images.orderApprovedSVG, "preOrder", "PRE ORDER"),
  remotePrint(Images.mobilePrintSVG, "remotePrint", "REMOTE PRINT"),
  stocks(Images.packageSVG, "stocks", "STOCKS"),
  collection(Images.collectionSVG, "collection", "COLLECTION"),
  purchaseOrder(Images.purchaseSVG, "purchaseOrder", "PURCHASE ORDER"),
  myOrder(Images.moneyHandSVG, "myOrder", "MR ORDER"),
  allService(Icons.more_horiz, "allService", "All Services");

  final dynamic image;
  final String name;
  final String key;

  const ServiceOne(this.image, this.key, this.name);
}
