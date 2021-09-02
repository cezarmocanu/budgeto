import 'package:budgeto_flutter/strings/strings.dart';
import 'package:flutter/material.dart';

class Category {
  String name = t(LabelsEnum.unknown);
  IconData icon = IconData(57522, fontFamily: 'MaterialIcons');

  Category.empty();

  Category.from(Category category) {
    this.name = category.name;
    this.icon = category.icon;
  }

  Category.withoutIcon(this.name);

  Category(this.name, this.icon);
}
