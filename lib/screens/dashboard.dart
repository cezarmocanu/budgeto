import 'package:budgeto_flutter/change-notifiers/app-model.dart';
import 'package:budgeto_flutter/common/snackbar-content.dart';
import 'package:budgeto_flutter/models/category.dart';
import 'package:budgeto_flutter/models/goal.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
      builder: (context, app, child) => Scaffold(
        body: SizedBox.expand(
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.all(20),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${app.income} \$",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Monthly Income",
                        style: TextStyle(fontSize: 12),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 12, bottom: 20),
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/addGoal');
                          },
                          label: const Text('Add new goal'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue[200],
                            onPrimary: Colors.blue[900],
                          ),
                        ),
                      ),
                      _RingChart(),
                    ],
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              Expanded(
                child: Card(
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: _CategoriesListView(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//TODO add appbar in a better design
class _AppBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
      builder: (context, app, child) => AppBar(
        title: Text("Monthly income ${app.income} \$"),
      ),
    );
  }
}

class _RingChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
      builder: (context, app, child) => PieChart(
        dataMap: app.categoriesChartDataMap,
        chartType: ChartType.ring,
        ringStrokeWidth: 32,
        colorList: [
          Colors.orange.shade300,
          Colors.amber.shade300,
          Colors.pink.shade300,
          Colors.purple.shade300,
          Colors.cyan.shade300,
          Colors.green.shade300,
          Colors.indigo.shade300
        ],
      ),
    );
  }
}

class _CategoriesListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(builder: (context, app, child) {
      List<Widget> expandableTiles = [];
      for (var category in app.categoriesMap.keys) {
        expandableTiles.add(
          _CategoryExpandableTile(category, app.categoriesMap[category] ?? []),
        );
      }

      return ListView(
        padding: const EdgeInsets.all(8),
        children: expandableTiles,
      );
    });
  }
}

class _CategoryExpandableTile extends StatelessWidget {
  final Category _category;
  final List<Goal> _goals;

  _CategoryExpandableTile(this._category, this._goals);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ExpansionTile(
        title: Text(_category.name),
        leading: Icon(_category.icon, color: Colors.pink),
        children: _goals
            .map(
              (goal) => ListTile(
                leading: CircularProgressIndicator(
                  value: goal.collected / goal.budget,
                  backgroundColor: Colors.black26,
                  color: Colors.pinkAccent,
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${goal.title}",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '${goal.collected} / ${goal.budget} \$',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    )
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pinkAccent,
                      ),
                      onPressed: () {
                        SnackbarContet contet =
                            Provider.of<AppModel>(context, listen: false)
                                .fundGoal(goal);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(contet.message),
                            duration: const Duration(seconds: 2),
                            backgroundColor: contet.backgroundColor,
                          ),
                        );
                      },
                      child: Text(
                        '${goal.allowance}/mo \$',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
