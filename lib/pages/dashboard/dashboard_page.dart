import 'package:budgeto_flutter/models/goal.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key, required this.planBudget, required this.goals})
      : super(key: key);

  final double planBudget;
  final List<Goal> goals;

  @override
  _DashboarState createState() => _DashboarState();
}

class _DashboarState extends State<DashboardPage> {
  ListView renderItems() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: widget.goals.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          color: Colors.amber[(index % 10) * 100 + 100],
          child: Center(
            child: ListTile(
              leading: Icon(widget.goals[index].category.icon),
              title: Column(
                children: [
                  Text("${widget.goals[index].title}"),
                  Text("Target : ${widget.goals[index].budget}"),
                ],
              ),
              trailing: Column(
                children: [
                  Container(
                    child: Text("+${widget.goals[index].allowance}"),
                    color: Colors.deepPurple[100],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/budgetForm');
          },
          child: Text("Your budget ${widget.planBudget} \$"),
        ),
      ),
      body: Center(
        child: renderItems(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/form');
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
