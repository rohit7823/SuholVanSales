import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suhol_van_sales/app/theme/images.dart';

enum BottomMenus {
  home(Icons.home_filled, "Home"),
  notification(Icons.notifications, "Notification"),
  settings(Icons.person, "Settings"),
  signOut(Icons.logout, "Sign Out");

  final IconData icon;
  final String name;

  const BottomMenus(this.icon, this.name);
}
