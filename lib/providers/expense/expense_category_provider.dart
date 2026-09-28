import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:isar_expense_tracker/util/func.dart';

final expenseCategoryProvider =
    StateNotifierProvider<ExpenseCategoryNotifier, AsyncValue<List<double>>>(
      (ref) => ExpenseCategoryNotifier(),
    );

class ExpenseCategoryNotifier extends StateNotifier<AsyncValue<List<double>>>
    with Func {
  ExpenseCategoryNotifier() : super(AsyncLoading()) {
    load();
  }

  Future<void> load() async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() => sumByCategory());
  }
}
