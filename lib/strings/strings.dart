import 'package:budgeto_flutter/strings/ro.dart';
import 'package:flutter/material.dart';

import 'en.dart';

enum LabelsEnum {
  addGoal,
  addCategory,
  allowance,
  category,
  customizeYourCategory,
  customizeYourGoal,
  english,
  expenses,
  exampleElectricGuitar,
  exampleNewCategory,
  exampleTargetGoal,
  exampleAllowance,
  goals,
  monthlyIncome,
  name,
  profile,
  romanian,
  setYourGoal,
  selectLanguage,
  target,
  unknown,
}

enum LanguageEnum {
  en,
  ro,
}

const Map<LanguageEnum, Map<LabelsEnum, String>> _LANGUAGE_DICT_MAP = {
  LanguageEnum.en: EN,
  LanguageEnum.ro: RO,
};

//TODO make the values of the labels constant?
const Map<LanguageEnum, String> LANGUAGES_MAP = {
  LanguageEnum.en: 'English',
  LanguageEnum.ro: 'Română',
};

String t(LabelsEnum label, [LanguageEnum language = LanguageEnum.en]) {
  Map<LabelsEnum, String>? dict = _LANGUAGE_DICT_MAP[language];

  if (dict == null) {
    throw ErrorDescription('Unknown language');
  }

  if (!dict.containsKey(label)) {
    return 'Label not found!';
  }

  return dict[label]!;
}
