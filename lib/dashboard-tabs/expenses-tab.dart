import 'package:budgeto_flutter/change-notifiers/app-model.dart';
import 'package:budgeto_flutter/constants/routes.dart';
import 'package:budgeto_flutter/models/expense.dart';
import 'package:budgeto_flutter/strings/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
      builder: (context, app, child) {
        return CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Card(
                    margin: EdgeInsets.all(20),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _ExpensesHeader(),
                          ...app.expenses
                              .map((expense) =>
                                  _ExpenseListItem(expense: expense))
                              .toList()
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

class _ExpensesHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LanguageEnum intl = Provider.of<AppModel>(context, listen: true).intl;

    return Column(
      children: [
        ElevatedButton.icon(
          icon: Icon(Icons.add),
          onPressed: () {
            goTo(context, RoutesEnum.AddExpense);
          },
          label: Text(
            t(LabelsEnum.addExpense, intl),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.pinkAccent[200],
            onPrimary: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _ExpenseListItem extends StatelessWidget {
  final Expense expense;

  _ExpenseListItem({required this.expense});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${expense.name}"),
      trailing: Text("${expense.value} \$"),
    );
  }
}
