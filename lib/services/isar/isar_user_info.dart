import 'package:isar/isar.dart';

import '../../models/userModel.dart';
import 'isar_repository.dart';

class UserInfoRepository extends BaseRepository<UserInfo> {
  UserInfoRepository(Isar isar) : super(isar, isar.userInfos);

  // Here you can add methods specific to UserInfo if necessary
  Future<String?> getToken() async {
    final users = await getAll();
    if (users.isEmpty) return null;
     
    return users.last.token;
  }
  
  Future<UserInfo?> getCurrentUser() async {
    final users = await getAll();
    return users.isNotEmpty ? users.last : null;
  }
}
