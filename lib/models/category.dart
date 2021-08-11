import 'package:flutter/material.dart';

class Category {
  String label = 'Unknown';
  IconData icon = IconData(57522, fontFamily: 'MaterialIcons');

  Category.empty();

  Category.withoutIcon(this.label);

  Category(this.label, this.icon);
}
