/*
class Constants {
  static Constants? _instance;
  // Avoid self isntance
  Constants._();
  static Constants get instance {
    _instance ??= Constants._();
    return _instance!;
  }

  String get ROUTE_LOGIN => '/login';
}
*/

enum RoutesName {
  loginPage('/login');

  final String route;
  const RoutesName(this.route);
}

enum SessionStorageKeys {
  accessToken('/ACCESS_TOKEN/');

  final String key;
  const SessionStorageKeys(this.key);
}
