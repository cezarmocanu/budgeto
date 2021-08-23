import 'package:budgeto_flutter/change-notifiers/app-model.dart';
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
          child: _PlansListView(),
        ));
  }
}

class _AppBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
      builder: (context, app, child) => AppBar(
        title: Text(app.title),
      ),
    );
  }
}

class _PlansListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
      builder: (context, app, child) => ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: app.budgetPlans.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            color: Colors.amber[(index % 10) * 100 + 100],
            child: Center(
              child: ListTile(
                // leading: Icon(widget.goals[index].category.icon),
                title: Column(
                  children: [
                    Text("${app.budgetPlans[index].title}"),
                    // Text("Target : ${widget.goals[index].budget}"),
                  ],
                ),
                // trailing: Column(
                //   children: [
                //     Container(
                //       child: Text("+${widget.goals[index].allowance}"),
                //       color: Colors.deepPurple[100],
                //     ),
                //   ],
                // ),
              ),
            ),
          );
        },
      ),
    );
  }
}
