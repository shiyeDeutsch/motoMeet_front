class ApiEndpoints {
  // Base URL components
  static const String scheme = 'http';
  static const String host = '10.0.2.2';
  static const int port = 7004;
  
  // Authentication endpoints
  static Uri login = Uri(
    scheme: scheme,
    host: host,
    path: 'api/auth/login',
    port: port,
  );
  
  static Uri register = Uri(
    scheme: scheme,
    host: host,
    path: 'api/auth/register',
    port: port,
  );
  
  static Uri refreshToken = Uri(
    scheme: scheme,
    host: host,
    path: 'api/auth/refresh',
    port: port,
  );
  
  static Uri logout = Uri(
    scheme: scheme,
    host: host,
    path: 'api/auth/logout',
    port: port,
  );
  
  static Uri forgotPassword = Uri(
    scheme: scheme,
    host: host,
    path: 'api/auth/forgot-password',
    port: port,
  );
  
  static Uri resetPassword = Uri(
    scheme: scheme,
    host: host,
    path: 'api/auth/reset-password',
    port: port,
  );
  
  // User endpoints
  static Uri users = Uri(
    scheme: scheme,
    host: host,
    path: 'api/users',
    port: port,
  );
  
  static Uri currentUser = Uri(
    scheme: scheme,
    host: host,
    path: 'api/users/me',
    port: port,
  );
  
  static Uri userProfile = Uri(
    scheme: scheme,
    host: host,
    path: 'api/users/profile',
    port: port,
  );
  
  static Uri updateProfile = Uri(
    scheme: scheme,
    host: host,
    path: 'api/users/profile',
    port: port,
  );
  
  static Uri changePassword = Uri(
    scheme: scheme,
    host: host,
    path: 'api/users/change-password',
    port: port,
  );
  
  // Route endpoints
  static Uri routes = Uri(
    scheme: scheme,
    host: host,
    path: 'api/routes',
    port: port,
  );
  
  static Uri popularRoutes = Uri(
    scheme: scheme,
    host: host,
    path: 'api/routes/popular',
    port: port,
  );
  
  static Uri nearbyRoutes = Uri(
    scheme: scheme,
    host: host,
    path: 'api/routes/nearby',
    port: port,
  );
  
  static Uri userRoutes = Uri(
    scheme: scheme,
    host: host,
    path: 'api/routes/user',
    port: port,
  );
  
  // Group endpoints
  static Uri groups = Uri(
    scheme: scheme,
    host: host,
    path: 'api/groups',
    port: port,
  );
  
  static Uri userGroups = Uri(
    scheme: scheme,
    host: host,
    path: 'api/groups/user',
    port: port,
  );
  
  static Uri popularGroups = Uri(
    scheme: scheme,
    host: host,
    path: 'api/groups/popular',
    port: port,
  );
  
  // Event endpoints
  static Uri events = Uri(
    scheme: scheme,
    host: host,
    path: 'api/events',
    port: port,
  );
  
  static Uri upcomingEvents = Uri(
    scheme: scheme,
    host: host,
    path: 'api/events/upcoming',
    port: port,
  );
  
  static Uri userEvents = Uri(
    scheme: scheme,
    host: host,
    path: 'api/events/user',
    port: port,
  );
  
  static Uri popularEvents = Uri(
    scheme: scheme,
    host: host,
    path: 'api/events/popular',
    port: port,
  );
  
  // Activity endpoints
  static Uri activities = Uri(
    scheme: scheme,
    host: host,
    path: 'api/activities',
    port: port,
  );
  
  static Uri activityTypes = Uri(
    scheme: scheme,
    host: host,
    path: 'api/activity-types',
    port: port,
  );
  
  // Media endpoints
  static Uri media = Uri(
    scheme: scheme,
    host: host,
    path: 'api/media',
    port: port,
  );
  
  static Uri upload = Uri(
    scheme: scheme,
    host: host,
    path: 'api/media/upload',
    port: port,
  );
  
  // Search endpoints
  static Uri search = Uri(
    scheme: scheme,
    host: host,
    path: 'api/search',
    port: port,
  );
  
  static Uri searchUsers = Uri(
    scheme: scheme,
    host: host,
    path: 'api/search/users',
    port: port,
  );
  
  static Uri searchRoutes = Uri(
    scheme: scheme,
    host: host,
    path: 'api/search/routes',
    port: port,
  );
  
  static Uri searchGroups = Uri(
    scheme: scheme,
    host: host,
    path: 'api/search/groups',
    port: port,
  );
  
  static Uri searchEvents = Uri(
    scheme: scheme,
    host: host,
    path: 'api/search/events',
    port: port,
  );
  
  // Notification endpoints
  static Uri notifications = Uri(
    scheme: scheme,
    host: host,
    path: 'api/notifications',
    port: port,
  );
  
  static Uri markAsRead = Uri(
    scheme: scheme,
    host: host,
    path: 'api/notifications/mark-read',
    port: port,
  );
  
  static Uri notificationSettings = Uri(
    scheme: scheme,
    host: host,
    path: 'api/notifications/settings',
    port: port,
  );
  
  // Geolocation endpoint
  static Uri geoLocation = Uri(
    scheme: scheme,
    host: host,
    path: 'api/users/geolocation',
    port: port,
  );
}
