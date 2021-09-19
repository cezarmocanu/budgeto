import 'package:budgeto_flutter/common/form/styled-form-header.dart';
import 'package:budgeto_flutter/constants/routes.dart';
import 'package:flutter/material.dart';

class WizzardStep1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Card(
          margin: EdgeInsets.all(20),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                StyledFormHeader(
                  title: 'Add a new expense',
                  backRoute: RoutesEnum.Dashboard,
                ),
                WizzardCardButton(
                  label: 'Unique Payment',
                  onTap: () => goTo(context, RoutesEnum.AddExpense),
                ),
                WizzardCardButton(
                  label: 'Recursive Payment',
                  onTap: () => {},
                ),
                WizzardCardButton(
                  label: 'Fund Goal',
                  onTap: () => {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WizzardCardButton extends StatelessWidget {
  final String label;
  final Function() onTap;

  WizzardCardButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 3,
          margin: EdgeInsets.only(top: 10),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
