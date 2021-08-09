import 'package:flutter/material.dart';
import '../../models/goal.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key, required this.title, required this.goals})
      : super(key: key);

  final String title;
  final List<Goal> goals;

  @override
  _DashboarState createState() => _DashboarState();
}

class _DashboarState extends State<DashboardPage> {
  int _budget = 9999;

  ListView renderItems() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: widget.goals.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            height: 50,
            color: Colors.amber[(index % 10) * 100 + 100],
            child: Center(
              child: Text(
                  "${widget.goals[index].title} - ${widget.goals[index].budget}"),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title} $_budget"),
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
