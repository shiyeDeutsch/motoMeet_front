class EndPoints {
  EndPoints();

  static const String scheme = 'https';
  static const String host = 'localhost';
  static const int port = 7004;

  static Uri register = Uri(
    scheme: scheme,
    host: host,
    path: 'api/register',
    port: port,
  );
}
