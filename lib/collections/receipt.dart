import 'package:isar_community/isar.dart';
import 'package:isar_expense_tracker/collections/expense.dart';

part 'receipt.g.dart';

@collection
class Receipt {
  Id id = Isar.autoIncrement;
  late String name;
  @Backlink(to: 'receipts')
  final expense = IsarLink<Expense>(); //only 1 expense linked
}
