import 'package:isar/isar.dart';

abstract class BaseRepository<T> {
  final Isar isar;
  final IsarCollection<T> collection;

  BaseRepository(this.isar, this.collection);

  Future<int> add(T item) async {
    return isar.writeTxn(() async {
      return await collection.put(item);
    });
  }

  Future<List<T>> getAll() async {
    return collection.where().findAll();
  }

  T? getLastSync() {
    return collection.where().findAllSync().lastOrNull;
  }

  Future<void> deleteAll() async {
    await isar.writeTxn(() async {
      await collection.clear();
    });
  }
}
