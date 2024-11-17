import 'package:flutter/material.dart';

enum BottomMenus {
  home(Icons.home_filled, "Home"),
  notification(Icons.notifications, "Notification"),
  settings(Icons.person, "Settings"),
  signOut(Icons.logout, "Sign Out");

  final IconData icon;
  final String name;

  const BottomMenus(this.icon, this.name);
}
