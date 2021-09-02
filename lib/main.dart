import 'package:budgeto_flutter/change-notifiers/app-model.dart';
import 'package:budgeto_flutter/constants/routes.dart';
import 'package:budgeto_flutter/screens/add_goal.dart';
import 'package:budgeto_flutter/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AppModel(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        ROUTES_MAP[RoutesEnum.Dashboard]!: (context) => Dashboard(),
        ROUTES_MAP[RoutesEnum.AddGoal]!: (context) => AddGoal(),
      },
    );
  }
}
