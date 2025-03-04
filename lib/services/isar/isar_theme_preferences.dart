import 'package:isar/isar.dart';
import '../../models/theme_preferences.dart';
import 'isar_repository.dart';

class IsarThemePreferencesService {
  final IsarRepository _isarRepo;

  IsarThemePreferencesService(this._isarRepo);

  Future<ThemePreferences> getThemePreferences() async {
    final isar = await _isarRepo.openIsar();
    
    // Attempt to load existing preferences
    final prefs = await isar.themePreferences
        .get(ThemePreferences.singletonId);
    
    // If no preferences exist, create default ones
    if (prefs == null) {
      final defaultPrefs = ThemePreferences.defaults();
      await saveThemePreferences(defaultPrefs);
      return defaultPrefs;
    }
    
    return prefs;
  }

  Future<void> saveThemePreferences(ThemePreferences prefs) async {
    final isar = await _isarRepo.openIsar();
    
    // Ensure we're using the singleton ID
    prefs.id = ThemePreferences.singletonId;
    
    await isar.writeTxn(() async {
      await isar.themePreferences.put(prefs);
    });
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
