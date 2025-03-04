import 'package:isar/isar.dart';

import '../../models/theme_preferences.dart';
import 'isar_repository.dart';

class IsarThemePreferencesRepository extends BaseRepository<ThemePreferences> {
  IsarThemePreferencesRepository(Isar isar) : super(isar, isar.themePreferences);

  Future<ThemePreferences> getThemePreferences() async {
    // Attempt to load existing preferences
    final prefs = await getById(ThemePreferences.singletonId);
    
    // If no preferences exist, create default ones
    if (prefs == null) {
      final defaultPrefs = ThemePreferences.defaults();
      await add(defaultPrefs);
      return defaultPrefs;
    }
    
    return prefs;
  }

  Future<void> saveThemePreferences(ThemePreferences prefs) async {
    // Ensure we're using the singleton ID
    prefs.id = ThemePreferences.singletonId;
    await update(prefs);
  }

  Future<void> saveThemeType(String themeType) async {
    final prefs = await getThemePreferences();
    prefs.themeType = themeType;
    await saveThemePreferences(prefs);
  }

  Future<void> saveThemeMode(String themeMode) async {
    final prefs = await getThemePreferences();
    prefs.themeMode = themeMode;
    await saveThemePreferences(prefs);
  }
}
