import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:isar_community/isar.dart';
import 'package:isar_expense_tracker/collections/budget.dart';
import 'package:isar_expense_tracker/providers/budget/budget_provider.dart';
import 'package:isar_expense_tracker/providers/expense/expense_provider.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ExpenseHeader extends ConsumerStatefulWidget {
  const ExpenseHeader({super.key});

  @override
  ConsumerState<ExpenseHeader> createState() => _ExpenseHeaderState();
}

class _ExpenseHeaderState extends ConsumerState<ExpenseHeader> {
  double percent = 0.0;
  double totalVal = 0.0;
  double budgetValue = 0.0;
  bool isLoading = false;
  TextEditingController budgetController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final AsyncValue<Budget?> budget = ref.watch(budgetProvider);
    final AsyncValue<double?> total = ref.watch(expenseProvider);
    percent = totalVal / budgetValue;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              title: Text(
                DateFormat.MMMM().format(DateTime.now()),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.teal,
                ),
              ),
              subtitle: Text(
                DateTime.now().year.toString(),
                style: TextStyle(color: Colors.teal),
              ),
            ),
            SizedBox(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: CircularPercentIndicator(
                  radius: 80,
                  lineWidth: 30,
                  progressColor: Colors.teal,
                  animation: true,
                  circularStrokeCap: CircularStrokeCap.round,
                  percent: percent,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: RichText(
                text: TextSpan(
                  text: total.when(
                    data: (data) => data.toString(),
                    error: (error, stackTrace) => 0.toString(),
                    loading: () => 'Loading...',
                  ),
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  children: [
                    TextSpan(
                      text: ' / ',
                      style: TextStyle(color: Colors.grey),
                    ),

                    TextSpan(
                      text: budget.when(
                        data: (data) => data?.amount.toString(),
                        error: (error, stackTrace) => 0.0.toString(),
                        loading: () => 'Loading..',
                      ),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                onPressed: () {
                  budgetController.text =
                      budget.value?.amount.toString() ?? 0.0.toString();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                        "Budget",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                          fontSize: 16,
                        ),
                      ),
                      content: TextField(
                        controller: budgetController,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 14),
                          hintText: "Enter Amount",
                          suffix: Text('\$'),
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            createNewBudget(budget);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                          ),
                          child: Text('Save'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(foregroundColor: Colors.teal),
                child: Text(
                  budget.value == null ? 'Create Budget' : 'Edit Budget',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createNewBudget(AsyncValue<Budget?> budget) {
    try {
      if (budget.value == null) {
        ref
            .read(budgetProvider.notifier)
            .create(double.parse(budgetController.text));
      } else {
        final Budget? bgt = budget.when(
          data: (data) => data,
          error: (error, stackTrace) => null,
          loading: () => null,
        );
        if (bgt != null) {
          bgt.amount = double.parse(budgetController.text);
          ref.read(budgetProvider.notifier).editBudget(bgt);
        }
      }
    } on IsarError catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    }
    Navigator.pop(context);
  }
}
