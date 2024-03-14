import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/userModel.dart';

class IsarService {
  late final Isar isar;

  IsarService();

  Future<void> initIsar() async {
    final dir = await getApplicationDocumentsDirectory();

    isar = await Isar.open([
      UserInfoSchema,
    ], directory: dir.path);
  }

  Future<int> addUser(UserInfo user) async {
    return isar.writeTxn(() async {
      return await isar.userInfos.put(user);
    });
  }

  UserInfo? getUserAsync() {
    final users = isar.userInfos.where().findAllSync().last;
    return users;
  }

  List<UserInfo?> getallSync() {
    final user = isar.userInfos.where().findAllSync();
    return user;
  }

  Future<String?> getToken() async {
    final users = await isar.userInfos.where().findAll();
    if (users.isNotEmpty) {
      return users.last.token;
    } else {
      return null; // or handle the situation appropriately if you expect some data
    }
  }

  Future<void> clearUser() async {
    await isar.writeTxn(() async {
      await isar.userInfos.clear();
    });
  }
}
