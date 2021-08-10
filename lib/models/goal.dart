import 'package:budgeto_flutter/models/category.dart';

class Goal {
  String title = 'Default title';
  int budget = 9999;
  Category category = Category.empty();

  Goal(this.title, this.budget, this.category);
}
