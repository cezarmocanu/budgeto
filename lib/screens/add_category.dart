import 'package:budgeto_flutter/change-notifiers/app-model.dart';
import 'package:budgeto_flutter/common/form/styled-dropdown.dart';
import 'package:budgeto_flutter/common/form/styled-form-field.dart';
import 'package:budgeto_flutter/common/form/styled-form-header.dart';
import 'package:budgeto_flutter/constants/routes.dart';
import 'package:budgeto_flutter/models/category.dart';
import 'package:budgeto_flutter/strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _COLORS = [
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
  late final List<DropdownMenuItem<Color>> _dropdownItems;

  @override
  void initState() {
    super.initState();
    _dropdownItems = _COLORS
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
  }

  void _handleNameSave(String? value) {
    setState(() {
      _category.name = value ?? '';
    });
  }

  void _handleColorChange(Color? c) {
    setState(() {
      _category.color = c ?? Colors.redAccent;
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
                StyledDropdown<Color>(
                  handleChange: _handleColorChange,
                  selected: _category.color,
                  items: _dropdownItems,
                  label: t(LabelsEnum.color, intl),
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
