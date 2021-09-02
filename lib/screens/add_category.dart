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
                _ColorsDropdown(
                  handleChange: (Color c) {
                    setState(() {
                      _category.color = c;
                    });
                  },
                  selected: _category.color,
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

//TODO create a generic dropdonw type

class _ColorsDropdown extends StatelessWidget {
  static const _COLORS = [
    Colors.redAccent,
    Colors.orangeAccent,
    Colors.amberAccent,
    Colors.yellowAccent,
    Colors.lightGreenAccent,
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.indigoAccent,
    Colors.purpleAccent,
    Colors.pinkAccent
  ];

  final void Function(Color) handleChange;
  final Color selected;

  _ColorsDropdown({
    required this.handleChange,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    LanguageEnum intl = Provider.of<AppModel>(context, listen: true).intl;
    var items = _COLORS
        .map(
          (color) => DropdownMenuItem<Color>(
            value: color,
            child: Container(
              height: 30,
              color: color,
            ),
          ),
        )
        .toList();
    return DropdownButtonFormField<Color>(
      isExpanded: true,
      value: selected,
      onChanged: (dynamic newValue) {
        handleChange(newValue);
      },
      items: items,
      decoration: InputDecoration(
        labelText: t(LabelsEnum.color, intl),
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
  }
}
