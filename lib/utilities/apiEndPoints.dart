class ApiEndpoints {
  // Base URL
  static const String baseUrl = 'https://api.motomeet.com';
  
  // Authentication endpoints
  static const String login = '/api/auth/login';
  static const String register = '/api/auth/register';
  static const String refreshToken = '/api/auth/refresh';
  static const String logout = '/api/auth/logout';
  static const String forgotPassword = '/api/auth/forgot-password';
  static const String resetPassword = '/api/auth/reset-password';
  
  // User endpoints
  static const String users = '/api/users';
  static const String currentUser = '/api/users/me';
  static const String userProfile = '/api/users/profile';
  static const String updateProfile = '/api/users/profile';
  static const String changePassword = '/api/users/change-password';
  
  // Route endpoints
  static const String routes = '/api/routes';
  static const String popularRoutes = '/api/routes/popular';
  static const String nearbyRoutes = '/api/routes/nearby';
  static const String userRoutes = '/api/routes/user';
  
  // Group endpoints
  static const String groups = '/api/groups';
  static const String userGroups = '/api/groups/user';
  static const String popularGroups = '/api/groups/popular';
  
  // Event endpoints
  static const String events = '/api/events';
  static const String upcomingEvents = '/api/events/upcoming';
  static const String userEvents = '/api/events/user';
  static const String popularEvents = '/api/events/popular';
  
  // Activity endpoints
  static const String activities = '/api/activities';
  static const String activityTypes = '/api/activity-types';
  
  // Media endpoints
  static const String media = '/api/media';
  static const String upload = '/api/media/upload';
  
  // Search endpoints
  static const String search = '/api/search';
  static const String searchUsers = '/api/search/users';
  static const String searchRoutes = '/api/search/routes';
  static const String searchGroups = '/api/search/groups';
  static const String searchEvents = '/api/search/events';
  
  // Notification endpoints
  static const String notifications = '/api/notifications';
  static const String markAsRead = '/api/notifications/mark-read';
  static const String notificationSettings = '/api/notifications/settings';
}
