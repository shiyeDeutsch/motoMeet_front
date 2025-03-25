import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../models/route.dart';
import '../../models/theme_preferences.dart';

// Import all model classes with Isar collections
import '../../models/userModel.dart';
import '../../models/event.dart';
import '../../models/group.dart';
import '../../models/notification.dart';
import '../../models/activity.dart';
import '../../models/geoLocationInfo.dart';
import '../../models/locationShare.dart';

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
        RoutePointSchema,
        // Route related schemas
        RouteSchema,
        ReviewSchema,
        TagSchema,
        PointOfInterestSchema,
        UserRouteSchema,
        UserRoutePointSchema,
        // Event related schemas
        EventSchema,
        EventStageSchema,
        EventParticipantSchema,
        EventStageParticipantSchema,
        UserRecentActivitySchema,
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

        // GeoLocation related schemas
        GeoLocationInfoSchema,
        
        // Location sharing related schemas
        SharedLocationSchema,
        LocationSharingSessionSchema,

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
