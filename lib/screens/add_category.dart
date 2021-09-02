import 'package:budgeto_flutter/change-notifiers/app-model.dart';
import 'package:budgeto_flutter/common/form/styled-form-field.dart';
import 'package:budgeto_flutter/common/form/styled-form-header.dart';
import 'package:budgeto_flutter/constants/routes.dart';
import 'package:budgeto_flutter/models/category.dart';
import 'package:budgeto_flutter/strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: _AddCategoryForm(),
        ),
      ),
    );
  }
}

class _AddCategoryForm extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<_AddCategoryForm> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final Category _category = Category.empty();

  void _handleNameSave(String? value) {
    setState(() {
      _category.name = value ?? '';
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
            title: t(LabelsEnum.customizeYourCategory, intl),
            backRoute: RoutesEnum.Dashboard,
          ),
          Expanded(
            child: Column(
              children: [
                StyledFormField(
                  label: t(LabelsEnum.name, intl),
                  hint: t(LabelsEnum.exampleNewCategory, intl),
                  onSaved: _handleNameSave,
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // if (_form.currentState!.validate()) {
              _form.currentState!.save();
              context.read<AppModel>().addCategory(Category.from(_category));
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
