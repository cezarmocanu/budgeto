import 'package:budgeto_flutter/change-notifiers/app-model.dart';
import 'package:budgeto_flutter/common/snackbar-content.dart';
import 'package:budgeto_flutter/constants/routes.dart';
import 'package:budgeto_flutter/strings/strings.dart';
import 'package:budgeto_flutter/models/category.dart';
import 'package:budgeto_flutter/models/goal.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class GoalsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LanguageEnum intl = Provider.of<AppModel>(context, listen: true).intl;

    return Consumer<AppModel>(
      builder: (context, app, child) {
        List<Widget> expandableTiles = [];
        for (var category in app.categoriesMap.keys) {
          expandableTiles.add(
            _CategoryExpandableTile(
                category, app.categoriesMap[category] ?? []),
          );
        }
        return CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                _ChartOverviewCard(),
                Card(
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 12, bottom: 20, left: 20),
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            goTo(context, RoutesEnum.AddCategory);
                          },
                          label: Text(
                            t(LabelsEnum.addCategory, intl),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.pinkAccent[200],
                            onPrimary: Colors.white,
                          ),
                        ),
                      ),
                      ...expandableTiles
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                )
              ]),
            ),
          ],
        );
      },
    );
  }
}

class _ChartOverviewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
        builder: (context, app, child) => Card(
              margin: EdgeInsets.all(20),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      //TODO make label dependant on currency
                      "${app.income} \$",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      t(LabelsEnum.monthlyIncome, app.intl),
                      style: TextStyle(fontSize: 12),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12, bottom: 20),
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          goTo(context, RoutesEnum.AddGoal);
                        },
                        label: Text(
                          t(LabelsEnum.addGoal, app.intl),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.pinkAccent[200],
                          onPrimary: Colors.white,
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
            ));
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
        leading: Icon(_category.icon, color: _category.color),
        children: _goals
            .map(
              (goal) => ListTile(
                leading: CircularProgressIndicator(
                  value: goal.collected / goal.budget,
                  backgroundColor: Colors.black26,
                  color: _category.color,
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${goal.name}",
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
