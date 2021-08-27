import 'package:budgeto_flutter/models/category.dart';
import 'package:intl/intl.dart';

class Goal {
  String title = 'Default title';
  double budget = 0;
  Category category = Category.empty();
  double allowance = 0;
  double _collected = 0;
  DateTime eta = DateTime.now();

  static DateFormat formatter = DateFormat('dd-MM-yyyy');

  Goal(this.title, this.budget, this.category, this.allowance) {
    int months = budget ~/ allowance;
    DateTime base = DateTime.now();
    eta = DateTime(base.year, base.month + months, base.day);
  }

  String get expectedTime => formatter.format(eta);

  void fundBudget(double fund) {
    _collected += fund;
  }

  double get collected {
    return _collected;
  }
}
