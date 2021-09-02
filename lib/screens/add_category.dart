import 'package:budgeto_flutter/change-notifiers/app-model.dart';
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

enum _Field {
  name,
}

class _AddCategoryForm extends StatelessWidget {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    LanguageEnum intl = Provider.of<AppModel>(context, listen: true).intl;

    final _controllers = Map<_Field, dynamic>.fromIterable(
      _Field.values,
      key: (field) => field,
      value: (_) => TextEditingController(),
    );

    //TODO abstract into an util
    Map<_Field, dynamic> getControllerValues() {
      return {_Field.name: _controllers[_Field.name].text};
    }

    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _FormHeader(),
          _FormField(
            label: t(LabelsEnum.name, intl),
            hint: t(LabelsEnum.exampleNewCategory, intl),
            controller: _controllers[_Field.name],
          ),
          ElevatedButton(
            onPressed: () {
              // if (_form.currentState!.validate()) {
              var values = getControllerValues();
              var app = context.read<AppModel>();
              app.addCategory(
                Category.withoutIcon(
                  values[_Field.name],
                ),
              );
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

//TODO replace with abstraction
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
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              t(LabelsEnum.customizeYourCategory, intl),
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

//TODO Abstract into a new component
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
