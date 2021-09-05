import 'package:budgeto_flutter/change-notifiers/app-model.dart';
import 'package:budgeto_flutter/common/form/styled-form-field.dart';
import 'package:budgeto_flutter/common/form/styled-form-header.dart';
import 'package:budgeto_flutter/constants/routes.dart';
import 'package:budgeto_flutter/models/expense.dart';
import 'package:budgeto_flutter/strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: AddExpenseForm(),
        ),
      ),
    );
  }
}

class AddExpenseForm extends StatefulWidget {
  AddExpenseForm({Key? key}) : super(key: key);

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<AddExpenseForm> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final Expense _expense = Expense.empty();

  void _handleNameSave(String? value) {
    setState(() {
      _expense.name = value ?? '';
    });
  }

  void _handleValueSave(String? value) {
    setState(() {
      _expense.value = double.tryParse(value ?? '') ?? -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    LanguageEnum intl = Provider.of<AppModel>(context, listen: true).intl;
    return Form(
      key: _form,
      child: Column(
        children: [
          StyledFormHeader(
            title: t(LabelsEnum.customizeYourExpense, intl),
            backRoute: RoutesEnum.Dashboard,
          ),
          StyledFormField(
            label: t(LabelsEnum.name, intl),
            hint: t(LabelsEnum.exampleExpense, intl),
            onSaved: _handleNameSave,
          ),
          StyledFormField(
            label: t(LabelsEnum.value, intl),
            hint: t(LabelsEnum.exampleValue, intl),
            onSaved: _handleValueSave,
          ),
          ElevatedButton(
            onPressed: () {
              // if (_form.currentState!.validate()) {
              _form.currentState!.save();
              context.read<AppModel>().addExpense(Expense.from(_expense));
              goTo(context, RoutesEnum.Dashboard);
              // }
            },
            child: Text(
              t(LabelsEnum.addCategory, intl),
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
