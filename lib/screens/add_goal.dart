import 'package:budgeto_flutter/change-notifiers/app-model.dart';
import 'package:budgeto_flutter/constants/routes.dart';
import 'package:budgeto_flutter/strings/strings.dart';
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
      body: Card(
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: _AddGoalForm(handleCategoryChange, selectedCategory),
        ),
      ),
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
    LanguageEnum intl = Provider.of<AppModel>(context, listen: true).intl;
    return Form(
      key: _form,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _FormHeader(),
          _FormField(
            label: t(LabelsEnum.name, intl),
            hint: t(LabelsEnum.exampleElectricGuitar, intl),
            controller: _controllers[_Field.name],
          ),
          _FormField(
            label: t(LabelsEnum.target, intl),
            hint: t(LabelsEnum.exampleTargetGoal, intl),
            controller: _controllers[_Field.budget],
            suffix: '\$',
          ),
          _FormField(
            label: t(LabelsEnum.allowance, intl),
            hint: t(LabelsEnum.exampleAllowance, intl),
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
              goTo(context, RoutesEnum.Dashboard);
              // }
            },
            child: Text(
              t(LabelsEnum.addGoal, intl),
            ),
            style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 40),
                primary: Colors.pinkAccent),
          ),
        ],
      ),
    );
  }
}

class _FormHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LanguageEnum intl = Provider.of<AppModel>(context, listen: true).intl;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Ink(
                  decoration: const ShapeDecoration(
                    color: Colors.pinkAccent,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    onPressed: () {
                      goTo(context, RoutesEnum.Dashboard);
                    },
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                  ),
                ),
              )),
          Expanded(
            flex: 2,
            child: Text(
              t(LabelsEnum.setYourGoal, intl),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final String hint;
  final String label;
  final TextEditingController controller;
  final String? suffix;

  _FormField({
    required this.hint,
    required this.controller,
    this.suffix,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hint,
        suffix: Text(suffix ?? ''),
        labelText: label,
        labelStyle: TextStyle(color: Colors.pinkAccent),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black12,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.pinkAccent,
            width: 2.0,
          ),
        ),
      ),
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
    LanguageEnum intl = Provider.of<AppModel>(context, listen: true).intl;
    return Consumer<AppModel>(builder: (context, app, child) {
      var items = app.categories
          .map((category) => DropdownMenuItem<Category>(
                value: category,
                child: Text('${category.name}'),
              ))
          .toList();
      return DropdownButtonFormField<Category>(
        isExpanded: true,
        value: selectedCategory,
        onChanged: (Category? newValue) {
          handleCategoryChange(newValue ?? Category.empty());
        },
        items: items,
        decoration: InputDecoration(
          labelText: t(LabelsEnum.category, intl),
          labelStyle: TextStyle(color: Colors.pinkAccent),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black12,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.pinkAccent,
              width: 2.0,
            ),
          ),
        ),
      );
    });
  }
}
