import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:motomeetfront/models/newRoute.dart';

part 'geoLocationInfo.g.dart';

@collection
@JsonSerializable()
class GeoLocationInfo {
  Id? id;
  
  @Embedded()
  GeoPoint? geoPoint;
  
  String? country;
  String? region;
  DateTime? lastUpdated;

  GeoLocationInfo({
    this.id,
    this.geoPoint,
    this.country,
    this.region,
    this.lastUpdated,
  });

  factory GeoLocationInfo.fromJson(Map<String, dynamic> json) =>
      _$GeoLocationInfoFromJson(json);

  Map<String, dynamic> toJson() => _$GeoLocationInfoToJson(this);

  GeoLocationInfo copyWith({
    Id? id,
    GeoPoint? geoPoint,
    String? country,
    String? region,
    DateTime? lastUpdated,
  }) {
    return GeoLocationInfo(
      id: id ?? this.id,
      geoPoint: geoPoint ?? this.geoPoint,
      country: country ?? this.country,
      region: region ?? this.region,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
