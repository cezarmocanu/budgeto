import 'package:budgeto_flutter/change-notifiers/app-model.dart';
import 'package:budgeto_flutter/constants/routes.dart';
import 'package:budgeto_flutter/screens/add_category.dart';
import 'package:budgeto_flutter/screens/add_expense.dart';
import 'package:budgeto_flutter/screens/add_goal.dart';
import 'package:budgeto_flutter/screens/dashboard.dart';
import 'package:budgeto_flutter/screens/onboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AppModel(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: ROUTES_MAP[RoutesEnum.Onboard]!,
      routes: {
        ROUTES_MAP[RoutesEnum.Onboard]!: (context) => Onboard(),
        ROUTES_MAP[RoutesEnum.Dashboard]!: (context) => Dashboard(),
        ROUTES_MAP[RoutesEnum.AddGoal]!: (context) => AddGoal(),
        ROUTES_MAP[RoutesEnum.AddCategory]!: (context) => AddCategory(),
        ROUTES_MAP[RoutesEnum.AddExpense]!: (context) => AddExpense(),
      },
    );
  }
}
