import 'package:budgeto_flutter/models/category.dart';

class Goal {
  String title = 'Default title';
  double budget = 0;
  Category category = Category.empty();
  double allowance = 0;
  double _collected = 0;

  Goal(this.title, this.budget, this.category, this.allowance);

  void fundBudget(double fund) {
    _collected += fund;
  }

  double get collected {
    return _collected;
  }
}
