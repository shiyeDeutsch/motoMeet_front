import 'package:isar/isar.dart';
import 'package:motomeetfront/models/geoLocationInfo.dart';
import 'package:motomeetfront/services/isar/isar_repository.dart';

/// Repository for handling GeoLocationInfo local storage operations
class IsarGeoLocationRepository extends BaseRepository<GeoLocationInfo> {
  IsarGeoLocationRepository(Isar isar) : super(isar, isar.GeoLocationInfo);

  // @override
  // Future<void> add(GeoLocationInfo item) async {
  //   await write((isar) async {
  //     await isar.geoLocationInfos.put(item);
  //   });
  // }

  // @override
  // Future<void> delete(GeoLocationInfo item) async {
  //   await write((isar) async {
  //     await isar.geoLocationInfos.delete(item.id ?? 0);
  //   });
  // }

  // @override
  // Future<List<GeoLocationInfo>> getAll() async {
  //   return await read((isar) async {
  //     return await isar.geoLocationInfos.where().findAll();
  //   });
  // }

  // @override
  // Future<GeoLocationInfo?> getById(int id) async {
  //   return await read((isar) async {
  //     return await isar.geoLocationInfos.get(id);
  //   });
  // }
  
  // /// Get the latest geo location info
  // Future<GeoLocationInfo?> getLatest() async {
  //   return await read((isar) async {
  //     return await isar.geoLocationInfos
  //         .where()
  //         .sortByTimestampDesc()
  //         .findFirst();
  //   });
  // }
}
