import 'package:flutter/material.dart';
import 'package:isar_expense_tracker/widgets/expense_header.dart';

class ExpenseHome extends StatefulWidget {
  const ExpenseHome({super.key});

  @override
  State<ExpenseHome> createState() => _ExpenseHomeState();
}

class _ExpenseHomeState extends State<ExpenseHome> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Expense Tracker',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.teal,
                fontSize: 16,
              ),
            ),
            Spacer(),
            IconButton(onPressed: () {}, icon: Icon(Icons.sync)),
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          ],
        ),
        ExpenseHeader(),
      ],
    );
  }
}
