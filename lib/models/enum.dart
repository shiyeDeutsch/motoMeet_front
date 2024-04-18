enum RouteTypeEnum {
  hiking,
  biking,
  motorcycle,
  jeep,
}

extension RouteTypeExtension on RouteTypeEnum {
  static RouteTypeEnum fromString(String value) {
    for (var routeType in RouteTypeEnum.values) {
      if (routeType.name.toLowerCase() == value.toLowerCase()) {
        return routeType;
      }
    }
    throw ArgumentError('Invalid route type: $value');
  }
}

enum TagEnum {
  Hiking,
  Biking,
  Skiing,
  JeepTouring,
  Motorcycling,
  AccessibleForWheelchairs,
  FamilyFriendly,
  SuitableForChildren,
  PetFriendly,
  ScenicViews,
  HistoricalLandmarks,
  WaterfallSightings,
  BirdWatching,
  CampingSites,
  WildflowerTrails,
  MountainBiking,
  CrossCountrySkiing,
  Snowshoeing,
  NatureReserves,
  EducationalTrails
}

extension TageEnumExtension on TagEnum {
  static int getId(TagEnum tagId) {
    switch (tagId) {
      case TagEnum.Hiking:
        return 1;
      case TagEnum.Biking:
        return 2;
      case TagEnum.Skiing:
        return 3;
      case TagEnum.JeepTouring:
        return 4;
      case TagEnum.Motorcycling:
        return 5;
      case TagEnum.AccessibleForWheelchairs:
        return 6;
      case TagEnum.FamilyFriendly:
        return 7;
      case TagEnum.SuitableForChildren:
        return 8;
      case TagEnum.PetFriendly:
        return 9;
      case TagEnum.ScenicViews:
        return 10;
      case TagEnum.HistoricalLandmarks:
        return 11;
      case TagEnum.WaterfallSightings:
        return 12;
      case TagEnum.BirdWatching:
        return 13;
      case TagEnum.CampingSites:
        return 14;
      case TagEnum.WildflowerTrails:
        return 15;
      case TagEnum.MountainBiking:
        return 16;
      case TagEnum.CrossCountrySkiing:
        return 17;
      case TagEnum.Snowshoeing:
        return 18;
      case TagEnum.NatureReserves:
        return 19;
      case TagEnum.EducationalTrails:
        return 20;
      default:
        return 0;
    }
  }

  String get name {
    return this.toString().split('.').last;
  }
  static TagEnum fromString(String value) {
    for (var routeTag in TagEnum.values) {
      if (routeTag.name.toLowerCase() == value.toLowerCase()) {
        return routeTag;
      }
    }
    throw ArgumentError('Invalid route type: $value');
  }
}
