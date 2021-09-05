class Expense {
  double value = 0;
  String name = "";

  Expense.empty();

  Expense.from(Expense expense) {
    this.value = expense.value;
    this.name = expense.name;
  }

  Expense({
    required this.value,
    required this.name,
  });
}
