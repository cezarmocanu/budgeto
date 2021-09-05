import 'package:flutter/material.dart';

enum RoutesEnum {
  Dashboard,
  AddGoal,
  AddCategory,
  AddExpense,
}

const Map<RoutesEnum, String> ROUTES_MAP = {
  RoutesEnum.Dashboard: '/',
  RoutesEnum.AddGoal: '/addGoal',
  RoutesEnum.AddCategory: '/addCategory',
  RoutesEnum.AddExpense: '/addExpense'
};

void goTo(BuildContext context, RoutesEnum route) {
  Navigator.pushReplacementNamed(context, ROUTES_MAP[route]!);
}
