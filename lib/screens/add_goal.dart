import 'package:budgeto_flutter/change-notifiers/app-model.dart';
import 'package:budgeto_flutter/models/category.dart';
import 'package:budgeto_flutter/models/goal.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AddGoal extends StatefulWidget {
  AddGoal({Key? key});

  @override
  _State createState() => _State();
}

class _State extends State<AddGoal> {
  Category selectedCategory = Category.empty();
  void handleCategoryChange(Category category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  void initState() {
    selectedCategory =
        Provider.of<AppModel>(context, listen: false).categories[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _AddGoalForm(handleCategoryChange, selectedCategory),
    );
  }
}

enum _Field { name, budget, allowance }

class _AddGoalForm extends StatelessWidget {
  final Category selectedCategory;
  final void Function(Category) handleCategoryChange;
  _AddGoalForm(this.handleCategoryChange, this.selectedCategory);

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final _controllers = Map<_Field, dynamic>.fromIterable(
    _Field.values,
    key: (field) => field,
    value: (_) => TextEditingController(),
  );

  Map<_Field, dynamic> getControllerValues() {
    return {
      _Field.name: _controllers[_Field.name].text,
      _Field.budget: double.tryParse(_controllers[_Field.budget].text) ?? 0,
      _Field.allowance:
          double.tryParse(_controllers[_Field.allowance].text) ?? 0,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        children: [
          _FormField(
            hint: "What is the name of your goal?",
            controller: _controllers[_Field.name],
          ),
          _FormField(
            hint: "What is the target budget for this goal?",
            controller: _controllers[_Field.budget],
            suffix: '\$',
          ),
          _FormField(
            hint: "How much are you going to spend on it each month?",
            controller: _controllers[_Field.allowance],
            suffix: '\$',
          ),
          _CategoryDropdown(
            handleCategoryChange: handleCategoryChange,
            selectedCategory: selectedCategory,
          ),
          ElevatedButton(
            onPressed: () {
              // if (_form.currentState!.validate()) {
              var values = getControllerValues();
              var app = context.read<AppModel>();
              app.addGoal(Goal(
                values[_Field.name],
                values[_Field.budget],
                selectedCategory,
                values[_Field.allowance],
              ));
              Navigator.pushReplacementNamed(context, '/');
              // }
            },
            child: const Text('Add Goal'),
          ),
        ],
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final String? suffix;

  _FormField({required this.hint, required this.controller, this.suffix});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: hint, suffix: Text(suffix ?? '')),
      controller: controller,
    );
  }
}

class _CategoryDropdown extends StatelessWidget {
  _CategoryDropdown(
      {required this.handleCategoryChange, this.selectedCategory});

  final void Function(Category) handleCategoryChange;
  final Category? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(builder: (context, app, child) {
      var items = app.categories
          .map((category) => DropdownMenuItem<Category>(
                value: category,
                child: Text('${category.name}'),
              ))
          .toList();
      return DropdownButton<Category>(
        value: selectedCategory,
        onChanged: (Category? newValue) {
          handleCategoryChange(newValue ?? Category.empty());
        },
        items: items,
      );
    });
  }
}
