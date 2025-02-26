class EndPoints {
  EndPoints();

  static const String scheme = 'http';
  static const String host = '10.0.2.2';
  static const int port = 7004;

  static Uri register = Uri(
    scheme: scheme,
    host: host,
    path: 'api/auth/register',
    port: port,
  );
  static Uri login = Uri(
    scheme: scheme,
    host: host,
    path: 'api/auth/login',
    port: port,
  );
  static Uri addNewRoute = Uri(
    scheme: scheme,
    host: host,
    path: 'api/routes',
    port: port,
  );
  static Uri userProfile = Uri(
    scheme: scheme,
    host: host,
    path: 'api/users/profile',
    port: port,
  );
  static Uri geoLocation = Uri(
    scheme: scheme,
    host: host,
    path: 'api/users/geolocation',
    port: port,
  );
  static Uri updateUserProfile = Uri(
    scheme: scheme,
    host: host,
    path: 'api/users/updateProfile',
    port: port,
  );
  static Uri deleteUser = Uri(
    scheme: scheme,
    host: host,
    path: 'api/users/delete',
    port: port,
  );
}
