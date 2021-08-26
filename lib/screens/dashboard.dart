import 'package:budgeto_flutter/change-notifiers/app-model.dart';
import 'package:budgeto_flutter/models/category.dart';
import 'package:budgeto_flutter/models/goal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
      builder: (context, app, child) => Scaffold(
        backgroundColor: Color.fromARGB(255, 250, 250, 250),
        body: Card(
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 12, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${app.income} \$",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Monthly Income",
                      style: TextStyle(fontSize: 12),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12),
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
                    )
                  ],
                ),
              ),
              Expanded(
                child: _CategoriesListView(),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.pushReplacementNamed(context, '/addGoal');
        //   },
        //   tooltip: 'Add new goal',
        //   child: Icon(Icons.add),
        // ),
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
                title: Text("${goal.title}"),
              ),
            )
            .toList(),
      ),
    );
  }
}
