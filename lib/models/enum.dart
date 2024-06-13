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

enum WaypointCategory { NaturalWaypoint, InformativeWaypoint, WarningWaypoint }

// Enum holding all possible waypoint types
enum WaypointType {
  // Natural Waypoints
  Lake,
  Cliff,
  Waterfall,
  WaterSpring,
  River,
  MountainPeak,
  Forest,
  Meadow,
  Cave,
  Valley,
  Beach,
  Glacier,
  Volcano,

  // Informative Waypoints
  HistoricalSite,
  VisitorCenter,
  Viewpoint,
  Museum,
  CulturalSite,
  EducationalTrail,
  ParkOffice,

  // Warning Waypoints
  SteepDrop,
  SlipperyPath,
  HighTide,
  WildlifeSighting,
  FloodingArea,
  Rockfall,
  RestrictedArea,
}

// Interface for Waypoint Enums
extension WaypointTypeExtension on WaypointType {
  static WaypointCategory getCategory(WaypointType type) {
    const naturalWaypointRange = {
      WaypointType.Lake,
      WaypointType.Cliff,
      WaypointType.Waterfall,
      WaypointType.WaterSpring,
      WaypointType.River,
      WaypointType.MountainPeak,
      WaypointType.Forest,
      WaypointType.Meadow,
      WaypointType.Cave,
      WaypointType.Valley,
      WaypointType.Beach,
      WaypointType.Glacier,
      WaypointType.Volcano,
    };

    const informativeWaypointRange = {
      WaypointType.HistoricalSite,
      WaypointType.VisitorCenter,
      WaypointType.Viewpoint,
      WaypointType.Museum,
      WaypointType.CulturalSite,
      WaypointType.EducationalTrail,
      WaypointType.ParkOffice,
    };

    const warningWaypointRange = {
      WaypointType.SteepDrop,
      WaypointType.SlipperyPath,
      WaypointType.HighTide,
      WaypointType.WildlifeSighting,
      WaypointType.FloodingArea,
      WaypointType.Rockfall,
      WaypointType.RestrictedArea,
    };

    if (naturalWaypointRange.contains(type)) {
      return WaypointCategory.NaturalWaypoint;
    } else if (informativeWaypointRange.contains(type)) {
      return WaypointCategory.InformativeWaypoint;
    } else if (warningWaypointRange.contains(type)) {
      return WaypointCategory.WarningWaypoint;
    } else {
      throw Exception('Invalid waypoint type');
    }
  }

  static WaypointType fromString(String value) {
    for (var type in WaypointType.values) {
      if (type.name.toLowerCase() == value.toLowerCase()) {
        return type;
      }
    }
    throw ArgumentError('Invalid route type: $value');
  }
}
