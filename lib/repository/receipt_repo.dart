import 'package:isar_community/isar.dart';
import 'package:isar_expense_tracker/adapter.dart';
import 'package:isar_expense_tracker/collections/receipt.dart';
import 'package:isar_expense_tracker/main.dart';

class ReceiptRepo extends Adapter<Receipt> {
  @override
  Future<void> createMultiObjects(List<Receipt> collections) async {
    await isar.writeTxn(() async {
      await isar.receipts.putAll(collections);
    });
  }

  @override
  Future<void> createObject(Receipt collection) async {
    await isar.writeTxn(() async {
      await isar.receipts.put(collection);
    });
  }

  @override
  Future<void> deleteMultiObjects(List<int> ids) async {
    await isar.writeTxn(() async {
      await isar.receipts.deleteAll(ids);
    });
  }

  @override
  Future<void> deleteObject(Receipt collection) async {
    await isar.writeTxn(() async {
      await isar.receipts.delete(collection.id);
    });
  }

  @override
  Future<List<Receipt>> getAllObjects() async {
    return await isar.receipts.where().findAll();
  }

  @override
  Future<Receipt?> getObjectById(int id) async {
    return await isar.receipts.get(id);
  }

  @override
  Future<List<Receipt?>> getObjectsById(List<int> id) async {
    return await isar.receipts.getAll(id);
  }

  @override
  Future<void> updateObject(Receipt collection) async {
    final exists = await isar.receipts.get(collection.id);
    if (exists != null)
      await isar.writeTxn(() async {
        isar.receipts.put(collection);
      });
  }

  Future<void> uploadReceipts(List<Receipt> receipts) async {
    isar.writeTxn(() async {
      await isar.receipts.putAll(receipts);
    });
  }

  Future<List<Receipt>> downloadReceipts() async {
    return await isar.receipts.where().findAll();
  }

  Future<void> clearGallery(List<Receipt> receipts) async {
    await isar.receipts.deleteAll(receipts.map((e) => e.id).toList());
  }
}
