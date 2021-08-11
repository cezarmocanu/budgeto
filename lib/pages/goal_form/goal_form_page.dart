import 'package:budgeto_flutter/models/category.dart';
import 'package:flutter/material.dart';

class GoalFormPage extends StatefulWidget {
  GoalFormPage(
      {Key? key, required this.handleFormSubmit, required this.categories})
      : super(key: key);

  final Function(String, int, Category) handleFormSubmit;
  final List<Category> categories;

  @override
  _State createState() => _State();
}

class _State extends State<GoalFormPage> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final goalTitleController = TextEditingController();
  final goalBudgetController = TextEditingController();
  Category categoryDropdownValue = Category.empty();

  void initState() {
    categoryDropdownValue = widget.categories[0];
    super.initState();
  }

  DropdownButton<Category> renderDropdownMenu() {
    return DropdownButton<Category>(
        value: categoryDropdownValue,
        onChanged: (Category? newValue) {
          setState(() {
            categoryDropdownValue = newValue!;
          });
        },
        items: widget.categories
            .map((category) => DropdownMenuItem<Category>(
                  value: category,
                  child: Text("${category.label}"),
                ))
            .toList());
  }

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
              },
              controller: goalBudgetController,
            ),
            renderDropdownMenu(),
            ElevatedButton(
              onPressed: () {
                if (_form.currentState!.validate()) {
                  var title = goalTitleController.text;
                  var budget = int.parse(goalBudgetController.text);
                  widget.handleFormSubmit(title, budget, categoryDropdownValue);
                  Navigator.pushNamed(context, '/');
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
