import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:isar_expense_tracker/util/func.dart';

final expenseProvider =
    StateNotifierProvider<ExpenseNotifier, AsyncValue<double?>>(
      (ref) => ExpenseNotifier(),
    );

class ExpenseNotifier extends StateNotifier<AsyncValue<double?>> with Func {
  ExpenseNotifier() : super(const AsyncLoading()) {
    load();
  }

  Future<void> load() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => getTotalExpenses());
  }
}
