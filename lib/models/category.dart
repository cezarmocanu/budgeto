import 'package:budgeto_flutter/constants/strings.dart';
import 'package:flutter/material.dart';

class Category {
  String name = t(LabelsEnum.unknown);
  IconData icon = IconData(57522, fontFamily: 'MaterialIcons');

  Category.empty();

  Category.withoutIcon(this.name);

  Category(this.name, this.icon);
}
