abstract class Adapter<T> {
  Future<void> createObject(T collection);
  Future<void> createMultiObjects(List<T> collections);
  Future<T?> getObjectById(int id);
  Future<List<T?>> getObjectsById(List<int> id);
  Future<List<T>> getAllObjects();
  Future<void> updateObject(T collection);
  Future<void> deleteObject(T collection);
  Future<void> deleteMultiObjects(List<int> ids);
}
