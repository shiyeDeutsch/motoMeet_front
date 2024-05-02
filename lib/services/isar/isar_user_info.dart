import 'package:isar/isar.dart';

import '../../models/userModel.dart';
import 'isar_reposetory.dart';

class UserInfoRepository extends BaseRepository<UserInfo> {
  UserInfoRepository(Isar isar) : super(isar, isar.userInfos);

  // Here you can add methods specific to UserInfo if necessary
  Future<String?> getToken() async {
    final users = await getAll();
    return users.isNotEmpty ? users.last.token : null;
  }
}
