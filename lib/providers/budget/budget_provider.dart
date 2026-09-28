import 'package:flutter_riverpod/legacy.dart';
import 'package:isar_expense_tracker/collections/budget.dart';
import 'package:isar_expense_tracker/util/func.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final budgetProvider =
    StateNotifierProvider<BudgetNotifier, AsyncValue<Budget?>>(
      (ref) => BudgetNotifier(),
    );

class BudgetNotifier extends StateNotifier<AsyncValue<Budget?>> with Func {
  BudgetNotifier() : super(const AsyncLoading()) {
    load();
  }
  Future<void> load() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => getBudget(month: DateTime.now().month, year: DateTime.now().year),
    );
  }

  Future<void> create(double amount) async {
    state = await AsyncValue.guard(() => createBudget(amount));
  }

  Future<void> editBudget(Budget budget) async {
    state = await AsyncValue.guard(() => updateBudget(budget));
  }
}
