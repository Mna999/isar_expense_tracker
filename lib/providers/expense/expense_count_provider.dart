import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:isar_expense_tracker/util/func.dart';

final expenseCountProvider =
    StateNotifierProvider<ExpenseCountNotifier, AsyncValue<int?>>(
      (ref) => ExpenseCountNotifier(),
    );

class ExpenseCountNotifier extends StateNotifier<AsyncValue<int?>> with Func {
  ExpenseCountNotifier() : super(AsyncLoading()) {
    load();
  }

  Future<void> load() async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() => expensesByCount());
  }
}
