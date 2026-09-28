import 'package:isar_community/isar.dart';
import 'package:isar_expense_tracker/adapter.dart';
import 'package:isar_expense_tracker/collections/budget.dart';
import 'package:isar_expense_tracker/main.dart';

class BudgetRepo extends Adapter<Budget> {
  @override
  Future<void> createMultiObjects(List<Budget> collections) async {
    await isar.writeTxn(() async {
      await isar.budgets.putAll(collections);
    });
  }

  @override
  Future<Budget?> createObject(Budget collection) async {
    await isar.writeTxn(() async {
      await isar.budgets.put(collection);
    });
    return await getObjectById(collection.id);
  }

  @override
  Future<void> deleteMultiObjects(List<int> ids) async {
    await isar.writeTxn(() async {
      await isar.budgets.deleteAll(ids);
    });
  }

  @override
  Future<void> deleteObject(Budget collection) async {
    await isar.writeTxn(() async {
      await isar.budgets.delete(collection.id);
    });
  }

  @override
  Future<List<Budget>> getAllObjects() async {
    return await isar.budgets.where().findAll();
  }

  @override
  Future<Budget?> getObjectById(int id) async {
    return await isar.budgets.get(id);
  }

  @override
  Future<List<Budget?>> getObjectsById(List<int> id) async {
    return await isar.budgets.getAll(id);
  }

  @override
  Future<Budget?> updateObject(Budget collection) async {
    await isar.writeTxn(() async {
      final exist = await isar.budgets.get(collection.id);
      if (exist != null) await isar.budgets.put(collection);
    });
    return await getObjectById(collection.id);
  }

  Future<Budget?> getObjectByDate({
    required int month,
    required int year,
  }) async {
    return await isar.budgets
        .filter()
        .monthEqualTo(month)
        .yearEqualTo(year)
        .findFirst();
  }
}
