import 'package:isar/isar.dart';

// Interface defining standard CRUD operations
abstract class Repository<T> {
  Future<int> add(T item);
  Future<List<T>> getAll();
  Future<T?> getById(Id id);
  Future<bool> update(T item);
  Future<bool> delete(Id id);
  Future<void> deleteAll();
}

// Base implementation for Isar entities
abstract class BaseRepository<T> implements Repository<T> {
  final Isar isar;
  final IsarCollection<T> collection;

  BaseRepository(this.isar, this.collection);

  @override
  Future<int> add(T item) async {
    int id = 0;
    await isar.writeTxn(() async {
      id = await collection.put(item);
    });
    return id;
  }

  @override
  Future<List<T>> getAll() async {
    return await collection.where().findAll();
  }
  
  @override
  Future<T?> getById(Id id) async {
    return await collection.get(id);
  }
  
  @override
  Future<bool> update(T item) async {
    bool success = false;
    await isar.writeTxn(() async {
      await collection.put(item);
      success = true;
    });
    return success;
  }
  
  @override
  Future<bool> delete(Id id) async {
    bool success = false;
    await isar.writeTxn(() async {
      success = await collection.delete(id);
    });
    return success;
  }

  @override
  Future<void> deleteAll() async {
    await isar.writeTxn(() async {
      await collection.clear();
    });
  }
  
  T? getLastSync() {
    return collection.where().findAllSync().lastOrNull;
  }
}
