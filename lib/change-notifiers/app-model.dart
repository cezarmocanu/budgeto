import 'dart:collection';

import 'package:budgeto_flutter/models/plan.dart';
import 'package:flutter/material.dart';

class AppModel extends ChangeNotifier {
  final List<Plan> _budgetPlans = [Plan("plan1"), Plan("plan2")];

  UnmodifiableListView<Plan> get budgetPlans =>
      UnmodifiableListView(_budgetPlans);

  String title = "hello form app model";
}
