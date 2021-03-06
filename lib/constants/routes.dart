import 'package:flutter/material.dart';

enum RoutesEnum {
  Onboard,
  Dashboard,
  AddGoal,
  AddCategory,
  AddExpense,
  WizzardStep1,
}

const Map<RoutesEnum, String> ROUTES_MAP = {
  RoutesEnum.Dashboard: '/',
  RoutesEnum.AddGoal: '/addGoal',
  RoutesEnum.Onboard: '/onboard',
  RoutesEnum.AddCategory: '/addCategory',
  RoutesEnum.AddExpense: '/addExpense',
  RoutesEnum.WizzardStep1: '/wizzard/1',
};

void goTo(BuildContext context, RoutesEnum route) {
  Navigator.pushReplacementNamed(context, ROUTES_MAP[route]!);
}
