import 'package:flutter/material.dart';

class BudgetFormPage extends StatefulWidget {
  BudgetFormPage({Key? key, required this.handleFormSubmit}) : super(key: key);

  final Function(double) handleFormSubmit;

  @override
  _State createState() => _State();
}

class _State extends State<BudgetFormPage> {
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  final budgetController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _form,
        child: Column(children: [
          TextFormField(
              controller: budgetController,
              decoration: const InputDecoration(
                hintText: 'Enter your budget for this plan',
              ),
              validator: (String? value) {
                var budget = double.tryParse(value ?? '');

                if (budget == null) {
                  return 'Please enter a valid budget';
                }

                if (budget < 0) {
                  return 'Cannot have negative budget';
                }

                if (budget == 0) {
                  return 'Cannot have 0 budget';
                }

                return null;
              }),
          ElevatedButton(
            onPressed: () {
              var budget = double.parse(budgetController.text);
              if (_form.currentState!.validate()) {
                widget.handleFormSubmit(budget);
                Navigator.pushNamed(context, '/');
              }
            },
            child: const Text('Submit'),
          )
        ]),
      ),
    );
  }
}
