import 'package:budgeto_flutter/change-notifiers/app-model.dart';
import 'package:budgeto_flutter/strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LanguageEnum intl = Provider.of<AppModel>(context, listen: true).intl;
    // var ddValues = getLanguagesDropdownValues(intl);

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
                  children: [_LanguageDropdown()],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LanguageEnum intl = Provider.of<AppModel>(context, listen: true).intl;
    return Consumer<AppModel>(builder: (context, app, child) {
      var items = LANGUAGES_MAP.keys
          .map(
            (language) => DropdownMenuItem<LanguageEnum>(
              value: language,
              child: Text(LANGUAGES_MAP[language]!),
            ),
          )
          .toList();
      return DropdownButtonFormField<LanguageEnum>(
        isExpanded: true,
        value: app.intl,
        onChanged: (LanguageEnum? newValue) {
          app.intl = newValue!;
        },
        items: items,
        decoration: InputDecoration(
          labelText: t(LabelsEnum.selectLanguage, intl),
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
