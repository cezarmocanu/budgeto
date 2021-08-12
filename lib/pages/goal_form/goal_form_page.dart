import 'package:budgeto_flutter/models/category.dart';
import 'package:flutter/material.dart';

class GoalFormPage extends StatefulWidget {
  GoalFormPage(
      {Key? key, required this.handleFormSubmit, required this.categories})
      : super(key: key);

  final Function(
    String,
    double,
    Category,
    double,
  ) handleFormSubmit;
  final List<Category> categories;

  @override
  _State createState() => _State();
}

enum FormField { title, budget, allowance }

class _State extends State<GoalFormPage> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  //TODO add reduce
  final Map<FormField, dynamic> controller = {
    FormField.title: TextEditingController(),
    FormField.budget: TextEditingController(),
    FormField.allowance: TextEditingController(),
  };
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

  //TODO should move this to utils
  Map<FormField, dynamic> getControllerValues(
      Map<FormField, dynamic> controllerMap) {
    var values = new Map<FormField, dynamic>();
    values[FormField.title] = controllerMap[FormField.title].text;
    values[FormField.budget] =
        double.tryParse(controllerMap[FormField.budget].text);
    values[FormField.allowance] =
        double.tryParse(controllerMap[FormField.allowance].text);
    return values;
  }

  @override
  void dispose() {
    controller.forEach((key, value) {
      value.dispose();
    });
    super.dispose();
  }

  String? doubleValidator(String? value) {
    var budget = double.tryParse(value ?? '');

    if (budget == null) {
      return 'Please enter a valid number';
    }

    if (budget < 0) {
      return 'Cannot have negative value';
    }

    if (budget == 0) {
      return 'Cannot have 0 value';
    }

    return null;
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
              controller: controller[FormField.title],
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter your goal target',
              ),
              validator: doubleValidator,
              controller: controller[FormField.budget],
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter your monthly allowance',
              ),
              validator: doubleValidator,
              controller: controller[FormField.allowance],
            ),
            renderDropdownMenu(),
            ElevatedButton(
              onPressed: () {
                if (_form.currentState!.validate()) {
                  var values = getControllerValues(controller);

                  widget.handleFormSubmit(
                    values[FormField.title],
                    values[FormField.budget],
                    categoryDropdownValue,
                    values[FormField.allowance],
                  );
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
