import 'package:flutter/material.dart';

class GoalFormPage extends StatefulWidget {
  GoalFormPage({Key? key, required this.handleFormSubmit}) : super(key: key);

  final Function(String, int) handleFormSubmit;

  @override
  _State createState() => _State();
}

class _State extends State<GoalFormPage> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final goalTitleController = TextEditingController();
  final goalBudgetController = TextEditingController();

  @override
  void dispose() {
    goalTitleController.dispose();
    goalBudgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _form,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter your goal name',
              ),
              controller: goalTitleController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter your goal target',
              ),
              controller: goalBudgetController,
            ),
            ElevatedButton(
              onPressed: () {
                var title = goalTitleController.text;
                var budget = int.parse(goalBudgetController.text);
                widget.handleFormSubmit(title, budget);
                Navigator.pushNamed(context, '/');
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
