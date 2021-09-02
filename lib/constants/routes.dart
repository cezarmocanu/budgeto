import 'package:flutter/material.dart';

enum RoutesEnum { Dashboard, AddGoal }

const Map<RoutesEnum, String> ROUTES_MAP = {
  RoutesEnum.Dashboard: '/',
  RoutesEnum.AddGoal: 'addGoal'
};

void goTo(BuildContext context, RoutesEnum route) {
  Navigator.pushReplacementNamed(context, ROUTES_MAP[route]!);
}
