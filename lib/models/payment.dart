import 'category.dart';
import 'goal.dart';

enum PaymentTypesEnum {
  UNIQUE,
  RECURSIVE,
  GOAL_FUND,
}

class Payment {
  late String _name;
  late double _value;
  late Category _category;
  late PaymentTypesEnum _type;

  Payment.unique({
    required String name,
    required double value,
    required Category category,
  }) {
    _name = name;
    _value = value;
    _category = category;
    _type = PaymentTypesEnum.UNIQUE;
  }

  Payment.recursive({
    required Payment payment,
    double? value,
  }) {
    _name = payment.name;
    _value = payment.value;
    _category = payment.category;
    _type = PaymentTypesEnum.RECURSIVE;
  }

  // TODO
  Payment.goal({
    required Goal goal,
  });

  String get name => _name;
  double get value => value;
  Category get category => _category;
}
