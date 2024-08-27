import 'package:suhol_van_sales/app/theme/images.dart';

enum Features {
  dashboard(Images.walletSVG,"DASHBOARD"),
  targets(Images.targetsSVG,  "MY TARGETS"),
  mis(Images.misSVG, "MIS"),
  reports(Images.reportsSVG,  "REPORTS");

  final String icon;
  final String text;

  const Features(this.icon, this.text);
}
