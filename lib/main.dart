import 'package:flutter/material.dart';
import './pages/dashboard/dashboard_page.dart';
import './pages/goal_form/goal_form_page.dart';
import './models/goal.dart';
import './models/category.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  List<Goal> _goals = [];
  List<Category> _categories = [
    Category('Food', IconData(57902, fontFamily: 'MaterialIcons')),
    Category('Travel', IconData(57453, fontFamily: 'MaterialIcons')),
    Category.withoutIcon('Bills')
  ];

  void handleFormSubmit(String title, int budget, Category category) {
    _goals.add(Goal(title, budget, category));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => DashboardPage(title: 'Your budget', goals: _goals),
        '/form': (context) => GoalFormPage(
              handleFormSubmit: handleFormSubmit,
              categories: _categories,
            ),
      },
    );
  }
}
