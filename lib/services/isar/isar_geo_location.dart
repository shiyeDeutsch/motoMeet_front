import 'package:isar/isar.dart';
import 'package:motomeetfront/models/geoLocationInfo.dart';
import 'package:motomeetfront/services/isar/isar_repository.dart';

class GeoLocationRepository extends BaseRepository<GeoLocationInfo> {
  GeoLocationRepository(Isar isar) : super(isar, isar.geoLocationInfos);

  Future<GeoLocationInfo?> getLatestLocation() async {
    final locations = await collection
        .where()
        .sortByLastUpdatedDesc()
        .findAll();
    
    return locations.isNotEmpty ? locations.first : null;
  }
  
  Future<void> updateLocationInfo(GeoLocationInfo locationInfo) async {
    locationInfo.lastUpdated = DateTime.now();
    await add(locationInfo);
  }
  
  Future<void> clearOldLocations({int keepCount = 5}) async {
    final allLocations = await collection
        .where()
        .sortByLastUpdatedDesc()
        .findAll();
    
    if (allLocations.length > keepCount) {
      for (var i = keepCount; i < allLocations.length; i++) {
        await delete(allLocations[i].id!);
      }
    }
  }
}
