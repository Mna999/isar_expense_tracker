import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:isar_expense_tracker/collections/budget.dart';
import 'package:isar_expense_tracker/collections/expense.dart';
import 'package:isar_expense_tracker/collections/income.dart';
import 'package:isar_expense_tracker/collections/receipt.dart';
import 'package:path_provider/path_provider.dart';

late Isar isar;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: const MyApp()));
  final dir = await getApplicationDocumentsDirectory();
  if (Isar.instanceNames.isEmpty)
    isar = await Isar.open(
      [BudgetSchema, ExpenseSchema, IncomeSchema, ReceiptSchema],
      directory: dir.path,
      name: 'expenseInstance',
      inspector: true,
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: Scaffold(),
    );
  }
}
