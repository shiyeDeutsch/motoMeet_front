import 'package:isar/isar.dart';
import 'package:motomeetfront/models/activity.dart';
import 'package:motomeetfront/services/isar/isar_initializer.dart';

class ActivityRepository {
  final Isar _isar;

  ActivityRepository({required Isar isar}) : _isar = isar;

  Future<List<UserActivity>> getActivities({
    int skip = 0,
    int limit = 20,
  }) async {
    final activityDtos = await _isar.activityDtos
        .where()
        .sortByTimestampDesc()
        .offset(skip)
        .limit(limit)
        .findAll();
    
    return activityDtos.map((dto) => dto.toActivity()).toList();
  }

  Future<UserActivity?> getActivity(String id) async {
    final activityDto = await _isar.activityDtos
        .filter()
        .idEqualTo(id)
        .findFirst();
    
    return activityDto?.toActivity();
  }

  Future<void> saveActivity(UserActivity activity) async {
    if (activity.id == null) return;
    
    final activityDto = ActivityDto.fromActivity(activity);
    
    await _isar.writeTxn(() async {
      await _isar.activityDtos.put(activityDto);
    });
  }

  Future<void> saveActivities(List<UserActivity> activities) async {
    final activityDtos = activities
        .where((activity) => activity.id != null)
        .map((activity) => ActivityDto.fromActivity(activity))
        .toList();
    
    await _isar.writeTxn(() async {
      await _isar.activityDtos.putAll(activityDtos);
    });
  }

  Future<void> deleteActivity(String id) async {
    await _isar.writeTxn(() async {
      await _isar.activityDtos.filter().idEqualTo(id).deleteFirst();
    });
  }

  Future<void> clearActivities() async {
    await _isar.writeTxn(() async {
      await _isar.activityDtos.clear();
    });
  }
}

@collection
class ActivityDto {
  Id isarId = Isar.autoIncrement;
  
  @Index(unique: true, caseSensitive: false)
  late String id;
  
  String? activityTypeId;
  String? activityTypeName;
  String? userId;
  String? username;
  String? userImageUrl;
  String? eventId;
  String? eventName;
  String? routeId;
  String? routeName;
  DateTime? timestamp;
  String? description;
  String? metadataJson;

  ActivityDto();

  factory ActivityDto.fromActivity(UserActivity activity) {
    final dto = ActivityDto()
      ..id = activity.id!
      ..activityTypeId = activity.activityType?.id
      ..activityTypeName = activity.activityType?.name
      ..userId = activity.user?.id
      ..username = activity.user?.username
      ..userImageUrl = activity.user?.profileImageUrl
      ..eventId = activity.event?.id
      ..eventName = activity.event?.name
      ..routeId = activity.route?.id
      ..routeName = activity.route?.name
      ..timestamp = activity.timestamp
      ..description = activity.description;
    
    // Serialize metadata to JSON string if needed
    // dto.metadataJson = jsonEncode(activity.metadata);
    
    return dto;
  }

  UserActivity toActivity() {
    return UserActivity(
      id: id,
      activityType: activityTypeId != null
          ? ActivityType(id: activityTypeId, name: activityTypeName)
          : null,
      user: userId != null
          ? UserModel(
              id: userId,
              username: username,
              profileImageUrl: userImageUrl,
            )
          : null,
      event: eventId != null
          ? Event(id: eventId, name: eventName)
          : null,
      route: routeId != null
          ? RouteModel(id: routeId, name: routeName)
          : null,
      timestamp: timestamp,
      description: description,
      // metadata: metadataJson != null ? jsonDecode(metadataJson!) : null,
    );
  }
}
