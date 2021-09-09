import 'package:budgeto_flutter/change-notifiers/app-model.dart';
import 'package:budgeto_flutter/common/form/styled-dropdown.dart';
import 'package:budgeto_flutter/strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  List<DropdownMenuItem<LanguageEnum>> _createDropdownItems() {
    return LANGUAGES_MAP.keys
        .map(
          (language) => DropdownMenuItem<LanguageEnum>(
            value: language,
            child: Text(LANGUAGES_MAP[language]!),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(builder: (context, app, child) {
      var _handleLanguageChange = (LanguageEnum? newValue) {
        app.intl = newValue!;
      };

      return Scaffold(
        body: SizedBox.expand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                margin: EdgeInsets.all(20),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _InfoRow(
                        icon: Icons.person,
                        label: "Username",
                        value: "John Doe",
                      ),
                      _InfoRow(
                        icon: Icons.monetization_on,
                        value: app.income.toString(),
                        label: "Monthly Income",
                      ),
                      StyledDropdown<LanguageEnum>(
                        handleChange: _handleLanguageChange,
                        selected: app.intl,
                        items: _createDropdownItems(),
                        label: t(LabelsEnum.selectLanguage, app.intl),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  _InfoRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10,
        bottom: 20,
        left: 8,
        right: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label: $value",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Icon(icon),
        ],
      ),
    );
  }
}
