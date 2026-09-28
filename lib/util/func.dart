import 'dart:io';

import 'package:isar_expense_tracker/collections/budget.dart';
import 'package:isar_expense_tracker/collections/expense.dart';
import 'package:isar_expense_tracker/collections/receipt.dart';
import 'package:isar_expense_tracker/repository/budget_repo.dart';
import 'package:isar_expense_tracker/repository/expense_repo.dart';
import 'package:isar_expense_tracker/repository/receipt_repo.dart';
import 'package:path_provider/path_provider.dart';

mixin Func {
  Future<Budget?> createBudget(double amount) async {
    final budget = Budget()
      ..month = DateTime.now().month
      ..year = DateTime.now().year
      ..amount = amount;
    return await BudgetRepo().createObject(budget);
  }

  Future<Budget?> getBudget({required int month, required int year}) async {
    return await BudgetRepo().getObjectByDate(month: month, year: year);
  }

  Future<Budget?> updateBudget(Budget budget) async {
    return await BudgetRepo().updateObject(budget);
  }

  Future<void> createExpense({
    required double amount,
    required DateTime date,
    required CategoryEnum cat,
    required String subCat,
    required Set<Receipt> receipts,
    required List<String> desc,
    required String paymentMethod,
  }) async {
    final formattedDate = date.copyWith(
      second: 0,
      microsecond: 0,
      millisecond: 0,
      minute: 0,
      hour: 0,
    );

    final subCategory = SubCategory()..name = subCat;

    for (Receipt receipt in receipts) {
      await ReceiptRepo().createObject(receipt);
    }
    Expense expense = Expense()
      ..amount = amount
      ..category = cat
      ..date = formattedDate
      ..description = desc
      ..paymentMethod = paymentMethod
      ..receipts.addAll(receipts)
      ..subCategory = subCategory;

    await ExpenseRepo().createObject(expense);
  }

  Future<List<Expense?>> getTodaysExpense() async {
    return await ExpenseRepo().getObjectsByToday();
  }

  Future<List<Expense>> getAllExpenses() async {
    return await ExpenseRepo().getAllObjects();
  }

  Future<String> getPath() async {
    Directory dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<List<Receipt>> getAllReceipts() async {
    return await ReceiptRepo().getAllObjects();
  }

  Future<void> clearData() async {
    await ExpenseRepo().clearData();
  }

  Future<int> getTotalExpenses() async {
    return await ExpenseRepo().getTotalExpenses();
  }

  Future<List<double>> sumByCategory() async {
    List<double> total = [];
    for (var value in CategoryEnum.values) {
      total.add(await ExpenseRepo().getSumOfCategory(value));
    }
    return total;
  }

  Future<List<Expense>> getExpensesByCategory(CategoryEnum value) async {
    return await ExpenseRepo().getObjectsByCategory(value);
  }

  Future<List<Expense>> expensesByAmountRange(
    double lowerAmount,
    double upperAmount,
  ) async {
    return await ExpenseRepo().getObjectByAmountRange(lowerAmount, upperAmount);
  }

  Future<List<Expense>> expensesByAmountGreaterThan(double amount) async {
    return await ExpenseRepo().getObjectsWithAmountGreaterThan(amount);
  }

  Future<List<Expense>> expensesByAmountLessThan(double amount) async {
    return await ExpenseRepo().getObjectsWithAmountLessThan(amount);
  }

  Future<List<Expense>> expensesByCategoryAndAmount(
    CategoryEnum cat,
    double amount,
  ) async {
    return await ExpenseRepo().getObjectsByOptions(cat, amount);
  }

  Future<List<Expense>> expensesByNotOtherCategory() async {
    return await ExpenseRepo().getObjectsNotOthersCategory();
  }

  Future<List<Expense>> expensesByGroupFilter(
    String searchText,
    DateTime date,
  ) async {
    return await ExpenseRepo().getObjectsByGroupFilter(searchText, date);
  }

  Future<List<Expense>> expensesByPayementMethod(String searchText) async {
    return await ExpenseRepo().getObjectBySearchText(searchText);
  }

  Future<List<Expense>> expensesByUsingAny(
    List<CategoryEnum> categories,
  ) async {
    return await ExpenseRepo().getObjectsUsingAnyOf(categories);
  }

  Future<List<Expense>> expensesByUsingAll(
    List<CategoryEnum> categories,
  ) async {
    return await ExpenseRepo().getObjectsUsingAllOf(categories);
  }

  Future<List<Expense>> expensesByTags(int tags) async {
    return await ExpenseRepo().getObjectsWithTags(tags);
  }

  Future<List<Expense>> expensesByTagName(String tags) async {
    return await ExpenseRepo().getObjectsWithTagName(tags);
  }

  Future<List<Expense>> expensesByReceipts(String receiptName) async {
    return await ExpenseRepo().getObjectByReceipts(receiptName);
  }

  Future<List<Expense>> expensesByPagination(int offset) async {
    return await ExpenseRepo().getObjectsAndPaginate(offset);
  }

  Future<List<Expense>> expensesByFindFirst() async {
    return await ExpenseRepo().getFirstObject();
  }

  Future<List<Expense>> expensesByDeleteFirst() async {
    return await ExpenseRepo().deleteFirstObject();
  }

  Future<int> expensesByCount() async {
    return await ExpenseRepo().getTotalExpenses();
  }

  Future<List<Expense>> expensesByFullTextSearch(String searchText) async {
    return await ExpenseRepo().fullTextSearch(searchText);
  }

  Future<List<Expense>> deleteItem(Expense collection) async {
    return await ExpenseRepo().deleteObject(collection);
  }

  Future<void> clearGallery(List<Receipt> receipts) async {
    await ReceiptRepo().clearGallery(receipts);
  }
}
