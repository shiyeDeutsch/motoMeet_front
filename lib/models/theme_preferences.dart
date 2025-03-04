import 'package:isar/isar.dart';

part 'theme_preferences.g.dart';

@collection
class ThemePreferences {
  Id id = Isar.autoIncrement;

  // The ID is always 1 for single-instance preferences
  static const int singletonId = 1;

  @Name('theme_type')
  String themeType = 'AppThemeType.adventure';

  @Name('theme_mode')
  String themeMode = 'AppThemeMode.system';

  ThemePreferences();

  // Factory constructor for creating a default instance
  factory ThemePreferences.defaults() {
    return ThemePreferences()
      ..id = singletonId
      ..themeType = 'AppThemeType.adventure'
      ..themeMode = 'AppThemeMode.system';
  }
}
