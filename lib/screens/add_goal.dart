import 'package:budgeto_flutter/change-notifiers/app-model.dart';
import 'package:budgeto_flutter/common/form/styled-form-field.dart';
import 'package:budgeto_flutter/common/form/styled-form-header.dart';
import 'package:budgeto_flutter/constants/routes.dart';
import 'package:budgeto_flutter/models/category.dart';
import 'package:budgeto_flutter/models/goal.dart';
import 'package:budgeto_flutter/strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddGoal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: _AddGoalForm(),
        ),
      ),
    );
  }
}

class _AddGoalForm extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<_AddGoalForm> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final Goal _goal = Goal.empty();

  @override
  void initState() {
    _goal.category = Provider.of<AppModel>(
      context,
      listen: false,
    ).categories[0];
    super.initState();
  }

  void _handleNameSave(String? value) {
    setState(() {
      _goal.name = value ?? '';
    });
  }

  void _handleBugetSave(String? value) {
    setState(() {
      _goal.budget = double.tryParse(value ?? '') ?? -1;
    });
  }

  void _handleAllowanceSave(String? value) {
    setState(() {
      _goal.allowance = double.tryParse(value ?? '') ?? -1;
    });
  }

  void _handleCategoryChange(Category? value) {
    setState(() {
      _goal.category = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    LanguageEnum intl = Provider.of<AppModel>(context, listen: true).intl;
    return Form(
      key: _form,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StyledFormHeader(
            title: t(LabelsEnum.customizeYourGoal, intl),
            backRoute: RoutesEnum.Dashboard,
          ),
          Expanded(
            child: Column(
              children: [
                StyledFormField(
                  label: t(LabelsEnum.name, intl),
                  hint: t(LabelsEnum.exampleElectricGuitar, intl),
                  onSaved: _handleNameSave,
                ),
                StyledFormField(
                  label: t(LabelsEnum.target, intl),
                  hint: t(LabelsEnum.exampleTargetGoal, intl),
                  onSaved: _handleBugetSave,
                ),
                StyledFormField(
                  label: t(LabelsEnum.allowance, intl),
                  hint: t(LabelsEnum.exampleAllowance, intl),
                  onSaved: _handleAllowanceSave,
                ),
                _CategoryDropdown(
                  handleCategoryChange: _handleCategoryChange,
                  selectedCategory: _goal.category,
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // if (_form.currentState!.validate()) {
              _form.currentState!.save();
              print(_goal);
              context.read<AppModel>().addGoal(Goal.from(_goal));
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

class _CategoryDropdown extends StatelessWidget {
  _CategoryDropdown({
    required this.handleCategoryChange,
    required this.selectedCategory,
  });

  final void Function(Category) handleCategoryChange;
  final Category? selectedCategory;

  @override
  Widget build(BuildContext context) {
    LanguageEnum intl = Provider.of<AppModel>(context, listen: true).intl;
    return Consumer<AppModel>(builder: (context, app, child) {
      var items = app.categories
          .map(
            (category) => DropdownMenuItem<Category>(
              value: category,
              child: Text('${category.name}'),
            ),
          )
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
