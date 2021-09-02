enum LabelsEnum {
  addGoal,
  allowance,
  category,
  expenses,
  exampleElectricGuitar,
  exampleTargetGoal,
  exampleAllowance,
  goals,
  monthlyIncome,
  name,
  profile,
  setYourGoal,
  target,
  unknown,
}

const Map<LabelsEnum, String> _LABELS_MAP = {
  LabelsEnum.addGoal: 'Add Goal',
  LabelsEnum.allowance: 'Allowance',
  LabelsEnum.category: 'Category',
  LabelsEnum.expenses: 'Expenses',
  LabelsEnum.exampleElectricGuitar: 'ex: Electric guitar',
  LabelsEnum.exampleTargetGoal: 'ex: 350 \$',
  LabelsEnum.exampleAllowance: 'ex: 50\$ (per month)',
  LabelsEnum.goals: 'Goals',
  LabelsEnum.monthlyIncome: 'Monthly Income',
  LabelsEnum.name: 'Name',
  LabelsEnum.profile: 'Profile',
  LabelsEnum.setYourGoal: 'SetYourGoal',
  LabelsEnum.target: 'Target',
  LabelsEnum.unknown: 'Unknown'
};

String t(LabelsEnum label) {
  if (!_LABELS_MAP.containsKey(label)) {
    return 'Label not found!';
  }

  return _LABELS_MAP[label]!;
}
