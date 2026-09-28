import 'package:isar_community/isar.dart';
import 'package:isar_expense_tracker/adapter.dart';
import 'package:isar_expense_tracker/collections/expense.dart';
import 'package:isar_expense_tracker/collections/receipt.dart';
import 'package:isar_expense_tracker/main.dart';

class ExpenseRepo extends Adapter<Expense> {
  @override
  Future<void> createMultiObjects(List<Expense> collections) async {
    isar.writeTxn(() async {
      await isar.expenses.putAll(collections);
    });
  }

  @override
  Future<void> createObject(Expense collection) async {
    await isar.writeTxn(() async {
      await isar.expenses.put(collection);
    });
  }

  @override
  Future<void> deleteMultiObjects(List<int> ids) async {
    await isar.writeTxn(() async {
      await isar.expenses.deleteAll(ids);
    });
  }

  @override
  Future<List<Expense>> deleteObject(Expense collection) async {
    await isar.writeTxn(() async {
      await isar.expenses.delete(collection.id);
    });

    return await isar.expenses.where().findAll();
  }

  @override
  Future<List<Expense>> getAllObjects() async {
    return await isar.expenses.where().findAll();
  }

  @override
  Future<Expense?> getObjectById(int id) async {
    return await isar.expenses.get(id);
  }

  @override
  Future<List<Expense?>> getObjectsById(List<int> id) async {
    return await isar.expenses.getAll(id);
  }

  @override
  Future<void> updateObject(Expense collection) async {
    final exist = await isar.expenses.get(collection.id);
    if (exist != null) await isar.expenses.put(collection);
  }

  Future<List<Expense?>> getObjectsByToday() async {
    return await isar.expenses
        .where()
        .dateEqualTo(
          DateTime.now().copyWith(
            hour: 0,
            minute: 0,
            second: 0,
            microsecond: 0,
            millisecond: 0,
          ),
        )
        .findAll();
  }

  Future<double> getSumOfCategory(CategoryEnum value) async {
    return await isar.expenses
        .filter()
        .categoryEqualTo(value)
        .amountProperty()
        .sum();
  }

  Future<List<Expense>> getObjectsByCategory(CategoryEnum value) async {
    return await isar.expenses.filter().categoryEqualTo(value).findAll();
  }

  Future<List<Expense>> getObjectByAmountRange(
    double lowerAmount,
    double upperAmount,
  ) async {
    return await isar.expenses
        .where()
        .amountBetween(lowerAmount, upperAmount, includeLower: false)
        .findAll();
  }

  Future<List<Expense>> getObjectsWithAmountGreaterThan(double amount) async {
    return await isar.expenses.where().amountGreaterThan(amount).findAll();
  }

  Future<List<Expense>> getObjectsWithAmountLessThan(double amount) async {
    return await isar.expenses.where().amountLessThan(amount).findAll();
  }

  Future<List<Expense>> getObjectsByOptions(
    CategoryEnum category,
    double amount,
  ) async {
    return await isar.expenses
        .filter()
        .categoryEqualTo(category)
        .or()
        .amountGreaterThan(amount)
        .findAll();
  }

  Future<List<Expense>> getObjectsNotOthersCategory() async {
    return await isar.expenses
        .filter()
        .not()
        .categoryEqualTo(CategoryEnum.others)
        .findAll();
  }

  Future<List<Expense>> getObjectsByGroupFilter(
    String searchText,
    DateTime date,
  ) async {
    return await isar.expenses
        .filter()
        .categoryEqualTo(CategoryEnum.others)
        .group(
          (q) => q.paymentMethodContains(searchText).or().dateEqualTo(date),
        )
        .findAll(); // group controls the logic flow (here: category==others and (paymentMethod==searchText or date==date))
  }

  Future<List<Expense>> getObjectBySearchText(String searchText) async {
    return await isar.expenses
        .filter()
        .paymentMethodStartsWith(searchText)
        .or()
        .paymentMethodEndsWith(searchText)
        .findAll();
  }

  Future<List<Expense>> getObjectsUsingAnyOf(
    List<CategoryEnum> categories,
  ) async {
    return await isar.expenses
        .filter()
        .anyOf(
          categories,
          (q, CategoryEnum category) => q.categoryEqualTo(category),
        )
        .findAll();
  }

  Future<List<Expense>> getObjectsUsingAllOf(
    List<CategoryEnum> categories,
  ) async {
    return await isar.expenses
        .filter()
        .allOf(categories, (q, category) => q.categoryEqualTo(category))
        .findAll();
  }

  Future<List<Expense>> getObjectsWithoutPaymentMethod() async {
    return await isar.expenses.filter().paymentMethodIsEmpty().findAll();
  }

  Future<List<Expense>> getObjectsWithTags(int tags) async {
    return await isar.expenses
        .filter()
        .descriptionLengthGreaterThan(tags)
        .findAll();
  }

  Future<List<Expense>> getObjectsWithTagName(String tag) async {
    return await isar.expenses
        .filter()
        .descriptionElementEqualTo(tag, caseSensitive: false)
        .findAll();
  }

  Future<List<Expense>> getObjectsBySubCategory(String value) async {
    return await isar.expenses
        .filter()
        .subCategory((q) => q.nameEqualTo(value))
        .findAll();
  }

  Future<List<Expense>> getObjectsAndPaginate(int offset) async {
    return await isar.expenses.where().offset(offset).limit(2).findAll();
  }

  Future<List<Expense>> getObjectByReceipts(String receiptName) async {
    return await isar.expenses
        .filter()
        .receipts(
          (q) => q.nameEqualTo(receiptName).or().nameContains(receiptName),
        )
        .findAll();
  }

  Future<List<Expense>> getObjectsWithDistinctValues() async {
    return await isar.expenses.where().distinctByCategory().findAll();
  }

  Future<List<Expense>> getFirstObject() async {
    List<Expense> querySelected = [];
    await isar.expenses.where().findFirst().then((value) {
      if (value != null) querySelected.add(value);
    });

    return querySelected;
  }

  Future<List<Expense>> deleteFirstObject() async {
    await isar.writeTxn(() async {
      await isar.expenses.where().deleteFirst();
    });
    return await isar.expenses.where().findAll();
  }

  Future<int> getTotalExpenses() async {
    return await isar.expenses.count();
  }

  Future<void> clearData() async {
    await isar.writeTxn(() => isar.clear());
  }

  Future<List<String?>> getPaymentProperty() async {
    return await isar.expenses.where().paymentMethodProperty().findAll();
  }

  Future<double> totalExpenses() async {
    return await isar.expenses.where().amountProperty().sum();
  }

  Future<double> totalExpenseByCategory() async {
    return await isar.expenses
        .where()
        .distinctByCategory()
        .amountProperty()
        .sum();
  }

  Future<List<Expense>> fullTextSearch(String searchText) async {
    return isar.expenses
        .filter()
        .descriptionElementContains(searchText)
        .findAll();
  }
}
