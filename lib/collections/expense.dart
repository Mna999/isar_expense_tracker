import 'package:isar_community/isar.dart';
import 'package:isar_expense_tracker/collections/receipt.dart';

part 'expense.g.dart';

@collection
class Expense {
  Id id = Isar.autoIncrement;
  @Index()
  late double amount;
  @Index()
  late DateTime date;
  @Enumerated(EnumType.name)
  CategoryEnum? category;
  SubCategory? subCategory;
  final receipts=IsarLinks<Receipt>(); // many receipts linked
  @Index(composite: [CompositeIndex('amount')])
  String? paymentMethod;
  @Index(type: IndexType.value,caseSensitive: false)
  List<String>? description;
}

enum CategoryEnum { bills, food, clothes, transport, fun, others }

@embedded
class SubCategory {
  String? name;
}
