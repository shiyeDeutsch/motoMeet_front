import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../models/theme_preferences.dart';

// Import all model classes with Isar collections
import '../../models/userModel.dart';
import '../../models/route.dart';
import '../../models/event.dart';
import '../../models/group.dart';
import '../../models/notification.dart';
import '../../models/activity.dart' as activity_model;
import '../../models/mapMarker.dart';
import '../../models/newRoute.dart';
import '../../models/geoLocationInfo.dart';

class IsarInitializer {
  late Isar isar;

  Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [
        // User related schemas
        UserInfoSchema,
        UserInfoFollowSchema,
        FavoriteSchema,
        
        // Route related schemas
        NewRouteSchema,
        
        // Event related schemas
        EventSchema,
        EventStageSchema,
        EventParticipantSchema,
        EventStageParticipantSchema,
        activity_model.ActivityTypeSchema,
        EventActivitySchema,
        EventItemSchema,
        
        // Group related schemas
        GroupSchema,
        GroupMemberSchema,
        GroupActivitySchema,
        GroupPostSchema,
        GroupPostCommentSchema,
        GroupPostAttachmentSchema,
        
        // Notification related schemas
        NotificationSchema,
        ReactionSchema,
        
        // Map marker related schemas
        MapMarkerSchema,

        // GeoLocation related schemas
        GeoLocationInfoSchema,

        // Theme preferences schema
        ThemePreferencesSchema,
      ],
      directory: dir.path,
    );
  }

  Isar getInstance() {
    return isar;
  }
}
