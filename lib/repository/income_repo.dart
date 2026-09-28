import 'package:isar_community/isar.dart';
import 'package:isar_expense_tracker/adapter.dart';
import 'package:isar_expense_tracker/collections/income.dart';
import 'package:isar_expense_tracker/main.dart';

class incomesRepo extends Adapter<Income> {
  @override
  Future<void> createMultiObjects(List<Income> collections) async {
    isar.writeTxn(() async {
      await isar.incomes.putAll(collections);
    });
  }

  @override
  Future<void> createObject(Income collection) async {
    await isar.writeTxn(() async {
      await isar.incomes.put(collection);
    });
  }

  @override
  Future<void> deleteMultiObjects(List<int> ids) async {
    await isar.writeTxn(() async {
      await isar.incomes.deleteAll(ids);
    });
  }

  @override
  Future<void> deleteObject(Income collection) async {
    await isar.writeTxn(() async {
      await isar.incomes.delete(collection.id);
    });
  }

  @override
  Future<List<Income>> getAllObjects() async {
    return await isar.incomes.where().findAll();
  }

  @override
  Future<Income?> getObjectById(int id) async {
    return await isar.incomes.get(id);
  }

  @override
  Future<List<Income?>> getObjectsById(List<int> id) async {
    return await isar.incomes.getAll(id);
  }

  @override
  Future<void> updateObject(Income collection) async {
    final exist = await isar.incomes.get(collection.id);
    if (exist != null) await isar.incomes.put(collection);
  }
}
