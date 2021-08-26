import 'package:budgeto_flutter/change-notifiers/app-model.dart';
import 'package:budgeto_flutter/models/category.dart';
import 'package:budgeto_flutter/models/goal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _AppBarTitle(),
      ),
      body: Center(
        child: _CategoriesListView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/addGoal');
        },
        tooltip: 'Add new goal',
        child: Icon(Icons.add),
      ),
    );
  }
}

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
      color: Colors.amber,
      child: ExpansionTile(
        title: Text(_category.name),
        children: _goals
            .map(
              (goal) => Card(
                color: Colors.blue,
                child: ListTile(title: Text("${goal.title}")),
              ),
            )
            .toList(),
      ),
    );
  }
}
