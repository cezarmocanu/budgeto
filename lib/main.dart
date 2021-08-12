import 'package:budgeto_flutter/pages/budget_form/budget_form_page.dart';
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
  List<Category> _categories = [
    Category('Food', IconData(57902, fontFamily: 'MaterialIcons')),
    Category('Travel', IconData(57453, fontFamily: 'MaterialIcons')),
    Category.withoutIcon('Bills')
  ];
  List<Goal> _goals = [];
  double _planBudget = 999.9;

  void initState() {
    setState(() {
      _goals = [Goal('Fly to amsterdam', 1000, _categories[1], 250)];
    });
    super.initState();
  }

  void handleFormSubmit(
    String title,
    double budget,
    Category category,
    double allowance,
  ) {
    setState(() {
      _planBudget -= allowance;
      _goals.add(Goal(title, budget, category, allowance));
    });
  }

  void handleBudgetFormSubmit(double targetBudget) {
    setState(() {
      _planBudget = targetBudget;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => DashboardPage(
              planBudget: _planBudget,
              goals: _goals,
            ),
        '/form': (context) => GoalFormPage(
              handleFormSubmit: handleFormSubmit,
              categories: _categories,
            ),
        '/budgetForm': (context) => BudgetFormPage(
              handleFormSubmit: handleBudgetFormSubmit,
            ),
      },
    );
  }
}
