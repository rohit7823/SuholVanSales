import 'package:suhol_van_sales/app/theme/images.dart';

enum BottomMenus {
  home(Images.home, "Home"),
  notification(Images.bell, "Notification"),
  settings(Images.settings, "Settings"),
  signOut(Images.exit, "Sign Out");

  final String image;
  final String name;

  const BottomMenus(this.image, this.name);
}
