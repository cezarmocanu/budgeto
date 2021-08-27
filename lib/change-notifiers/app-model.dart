import 'package:budgeto_flutter/models/category.dart';
import 'package:budgeto_flutter/models/goal.dart';
import 'package:flutter/material.dart';

class AppModel extends ChangeNotifier {
  late List<Category> _categories;
  late List<Goal> _goals;
  double income = 874;

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

  void addGoal(Goal goal) {
    print(goal.title);
    print(goal.category.name);
    _goals.add(goal);
    notifyListeners();
  }

  List<Category> get categories => _categories;

  String title = "hello form app model";
}
