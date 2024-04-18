class EndPoints {
  EndPoints();

  static const String scheme = 'https';
  static const String host = 'localhost';
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
}
