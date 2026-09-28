import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:isar_expense_tracker/collections/expense.dart';
import 'package:isar_expense_tracker/util/func.dart';

final expenseFilterProvider =
    StateNotifierProvider<ExpenseFilterNotifier, AsyncValue<List<Expense>>>(
      (ref) => ExpenseFilterNotifier(),
    );

class ExpenseFilterNotifier extends StateNotifier<AsyncValue<List<Expense>>>
    with Func {
  ExpenseFilterNotifier() : super(AsyncData<List<Expense>>([]));
  void resetResults() async {
    state = AsyncData<List<Expense>>([]);
  }

  Future<void> filterByCategory(CategoryEnum value) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() => getExpensesByCategory(value));
  }

  Future<void> filterByAmountRange(double low, double high) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() => expensesByAmountRange(low, high));
  }

  Future<void> filterByAmountGreaterThan(double amount) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() => expensesByAmountGreaterThan(amount));
  }

  Future<void> filterByAmountLessThan(double amount) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() => expensesByAmountLessThan(amount));
  }

  Future<void> filterByAmountAndCategory(
    double amount,
    CategoryEnum cat,
  ) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(
      () => expensesByCategoryAndAmount(cat, amount),
    );
  }

  Future<void> filterByNotOtherCategory() async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() => expensesByNotOtherCategory());
  }

  Future<void> filterByGroupFilter(String searchText, DateTime date) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(
      () => expensesByGroupFilter(searchText, date),
    );
  }

  Future<void> filterByPaymentMethod(String searchText) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() => expensesByPaymentMethod(searchText));
  }

  Future<void> filterByUsingAny(List<CategoryEnum> categories) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() => expensesByUsingAny(categories));
  }

  Future<void> filterByUsingAll(List<CategoryEnum> categories) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() => expensesByUsingAll(categories));
  }

  Future<void> filterByTags(int tags) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() => expensesByTags(tags));
  }

  Future<void> filterByTagName(String tags) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() => expensesByTagName(tags));
  }

  Future<void> filterBySubCategory(String subCat) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() => expensesBySubCategory(subCat));
  }

  Future<void> filterByReceipt(String receiptName) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() => expensesByReceipts(receiptName));
  }

  Future<void> filterByPagination(int offset) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() => expensesByPagination(offset));
  }

  Future<void> filterByFindingFirst() async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() => expensesByFindFirst());
  }

  Future<void> filterByDeletingFirst() async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() => expensesByDeleteFirst());
  }

  Future<void> filterByFullTextSearch(String searchText) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() => expensesByFullTextSearch(searchText));
  }

  Future<void> deleteExpense(Expense expense) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() => deleteItem(expense));
    
  }
}
