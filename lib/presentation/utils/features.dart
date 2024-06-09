import 'package:flutter/material.dart';

enum Features {
  cashOrder(Icons.payments_outlined, "Cash Order"),
  creditOrder(Icons.credit_card, "Credit Order"),
  cashList(Icons.list_rounded, "Cash List"),
  creditList(Icons.checklist_sharp, "Credit List"),
  notifications(Icons.notifications_active, "Notifications");

  final IconData? icon;
  final String name;
  const Features(this.icon, this.name);
}
