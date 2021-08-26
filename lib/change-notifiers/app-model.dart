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
      Category.withoutIcon('Bills')
    ];

    _goals = [
      Goal('Fly to Amsterdam', 1000, _categories[1], 250),
      Goal('Apples', 1000, _categories[0], 250),
      Goal('Fly to Blacic', 1000, _categories[1], 250),
      Goal('Greens', 1000, _categories[0], 250),
      Goal('Fly to Blacic', 1000, _categories[1], 250),
      Goal('Vegetables', 1000, _categories[0], 250),
      Goal('Fly to Blacic', 1000, _categories[1], 250),
      Goal('Gas', 1000, _categories[2], 250),
      Goal('Water', 1000, _categories[2], 250),
    ];
  }

  Map<Category, List<Goal>> get categoriesMap {
    Map<Category, List<Goal>> dataMap = Map();
    _categories.forEach((category) => dataMap.putIfAbsent(category,
        () => _goals.where((goal) => goal.category == category).toList()));
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
