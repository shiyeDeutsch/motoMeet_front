import 'package:isar/isar.dart';
import 'package:motomeetfront/services/isar/isar_geo_location.dart';
import 'package:motomeetfront/services/isar/isar_user_info.dart';

class RepositoryProvider {
  final Isar isar;

  UserInfoRepository? _userInfoRepository;
  GeoLocationRepository? _geoLocationRepository;

  RepositoryProvider(this.isar);

  UserInfoRepository get userInfoRepository {
    _userInfoRepository ??= UserInfoRepository(isar);
    return _userInfoRepository!;
  }

  GeoLocationRepository get geoLocationRepository {
    _geoLocationRepository ??= GeoLocationRepository(isar);
    return _geoLocationRepository!;
  }

  // Add other repositories similarly

  // Optionally, you can add a method to clear or reset repositories if needed
  void clearRepositories() {
    _userInfoRepository = null;
    _geoLocationRepository = null;
    // Reset other repositories
  }

  Future<void> deleteAllRposetories() async {
    await _userInfoRepository?.deleteAll();
    await _geoLocationRepository?.deleteAll();
  }
}
