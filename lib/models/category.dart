import 'package:flutter/material.dart';

class Category {
  String name = 'Unknown';
  IconData icon = IconData(57522, fontFamily: 'MaterialIcons');

  Category.empty();

  Category.withoutIcon(this.name);

  Category(this.name, this.icon);
}
