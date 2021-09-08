import 'package:budgeto_flutter/common/snackbar-content.dart';
import 'package:budgeto_flutter/models/category.dart';
import 'package:budgeto_flutter/models/expense.dart';
import 'package:budgeto_flutter/models/goal.dart';
import 'package:budgeto_flutter/strings/strings.dart';
import 'package:flutter/material.dart';

class AppModel extends ChangeNotifier {
  late List<Category> _categories;
  late List<Goal> _goals;
  late List<Expense> _expenses;

  LanguageEnum _intl = LanguageEnum.en;
  double income = 3201;

  double get expended => _expenses.fold(
        0,
        (total, expense) => expense.value + total,
      );

  AppModel() {
    _categories = [
      Category('Food', IconData(57902, fontFamily: 'MaterialIcons')),
      Category('Travel', IconData(57453, fontFamily: 'MaterialIcons')),
      Category.withoutIcon('Bills'),
      Category('Music', IconData(57453, fontFamily: 'MaterialIcons')),
      Category.withoutIcon('Gym'),
      Category('Food2', IconData(57902, fontFamily: 'MaterialIcons')),
      Category('Travel2', IconData(57453, fontFamily: 'MaterialIcons'))
    ];

    _goals = [
      Goal('Fly to Amsterdam', 1000, _categories[1], 750),
      Goal('Apples', 1000, _categories[0], 750),
      Goal('Fly to Blacic', 1000, _categories[1], 750),
      Goal('Greens', 1000, _categories[0], 750),
      Goal('Fly to Blacic', 1000, _categories[1], 750),
      Goal('Vegetables', 1000, _categories[0], 650),
      Goal('Fly to Blacic', 1000, _categories[1], 550),
      Goal('Gas', 1000, _categories[3], 450),
      Goal('Water', 1000, _categories[4], 350),
      Goal('Gas', 1000, _categories[5], 250),
      Goal('Water', 1000, _categories[6], 150),
    ];

    _expenses = [];
  }

  Map<Category, List<Goal>> get categoriesMap {
    Map<Category, List<Goal>> dataMap = Map();
    _categories.forEach((category) => dataMap.putIfAbsent(category,
        () => _goals.where((goal) => goal.category == category).toList()));
    return dataMap;
  }

  Map<String, double> get categoriesChartDataMap {
    Map<String, double> dataMap = Map();
    _categories.forEach((category) => dataMap.putIfAbsent(
        category.name,
        () => _goals
            .where((goal) => goal.category == category)
            .fold(0, (sum, goal) => sum + goal.allowance)));
    return dataMap;
  }

  LanguageEnum get intl => _intl;

  set intl(LanguageEnum language) {
    _intl = language;
    notifyListeners();
  }

  get expenses => _expenses;

  void addCategory(Category category) {
    _categories.add(category);
    notifyListeners();
  }

  void addGoal(Goal goal) {
    _goals.add(goal);
    notifyListeners();
  }

  void addExpense(Expense expense) {
    _expenses.add(expense);
    notifyListeners();
  }

  //TODO add internationalization
  SnackbarContet fundGoal(Goal goal) {
    if (expended + goal.allowance <= income) {
      int index = _goals.indexWhere((element) => element.id == goal.id);
      var targetGoal = _goals[index];
      targetGoal.fundBudget(targetGoal.allowance);

      addExpense(Expense(name: targetGoal.name, value: targetGoal.allowance));

      notifyListeners();
      return SnackbarContet(
        message: 'Goal funded succesfully',
        backgroundColor: Colors.lightGreen,
      );
    } else {
      return SnackbarContet(
        message: 'Not enough money',
        backgroundColor: Colors.redAccent,
      );
    }
  }

  List<Category> get categories => _categories;
}
