import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/theme_preferences.dart';
import '../services/isar/isar_theme_preferences.dart';
import 'app_theme.dart';
import 'themes/adventure_theme.dart';
import 'themes/modern_explorer_theme.dart';
import 'themes/trail_map_theme.dart';
import 'themes/community_adventure_theme.dart';
import 'themes/technical_equipment_theme.dart';

/// Enum representing available themes in the app
enum AppThemeType {
  adventure,
  modernExplorer,
  trailMap,
  communityAdventure,
  technicalEquipment,
}

/// Enum representing theme mode (light or dark)
enum AppThemeMode {
  light,
  dark,
  system,
}

/// Class for managing theme state
class ThemeState {
  final AppTheme currentTheme;
  final AppThemeType themeType;
  final AppThemeMode themeMode;
  final bool isSystemMode;

  const ThemeState({
    required this.currentTheme,
    required this.themeType,
    required this.themeMode,
    this.isSystemMode = false,
  });

  ThemeState copyWith({
    AppTheme? currentTheme,
    AppThemeType? themeType,
    AppThemeMode? themeMode,
    bool? isSystemMode,
  }) {
    return ThemeState(
      currentTheme: currentTheme ?? this.currentTheme,
      themeType: themeType ?? this.themeType,
      themeMode: themeMode ?? this.themeMode,
      isSystemMode: isSystemMode ?? this.isSystemMode,
    );
  }

  ThemeMode get flutterThemeMode {
    switch (themeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  ThemeData getThemeData(BuildContext context) {
    if (themeMode == AppThemeMode.system) {
      final brightness = MediaQuery.of(context).platformBrightness;
      return brightness == Brightness.dark ? currentTheme.darkTheme : currentTheme.lightTheme;
    }
    return themeMode == AppThemeMode.dark ? currentTheme.darkTheme : currentTheme.lightTheme;
  }
}

/// Notifier class for theme state management
class ThemeNotifier extends StateNotifier<ThemeState> {
  final IsarThemePreferencesService _themeService;

  ThemeNotifier(this._themeService)
      : super(ThemeState(
          currentTheme: AdventureTheme(),
          themeType: AppThemeType.adventure,
          themeMode: AppThemeMode.system,
          isSystemMode: true,
        )) {
    _loadSavedTheme();
  }

  Future<void> _loadSavedTheme() async {
    final prefs = await _themeService.getThemePreferences();
    
    AppThemeType themeType = AppThemeType.adventure;
    if (prefs.themeType.isNotEmpty) {
      try {
        final enumString = prefs.themeType.split('.').last;
        themeType = AppThemeType.values.firstWhere(
          (e) => e.toString().split('.').last == enumString,
          orElse: () => AppThemeType.adventure,
        );
      } catch (_) {}
    }

    AppThemeMode themeMode = AppThemeMode.system;
    if (prefs.themeMode.isNotEmpty) {
      try {
        final enumString = prefs.themeMode.split('.').last;
        themeMode = AppThemeMode.values.firstWhere(
          (e) => e.toString().split('.').last == enumString,
          orElse: () => AppThemeMode.system,
        );
      } catch (_) {}
    }

    setTheme(themeType);
    setThemeMode(themeMode);
  }

  void setTheme(AppThemeType themeType) {
    AppTheme newTheme;

    switch (themeType) {
      case AppThemeType.adventure:
        newTheme = AdventureTheme();
        break;
      case AppThemeType.modernExplorer:
        newTheme = ModernExplorerTheme();
        break;
      case AppThemeType.trailMap:
        newTheme = TrailMapTheme();
        break;
      case AppThemeType.communityAdventure:
        newTheme = CommunityAdventureTheme();
        break;
      case AppThemeType.technicalEquipment:
        newTheme = TechnicalEquipmentTheme();
        break;
    }

    state = state.copyWith(
      currentTheme: newTheme,
      themeType: themeType,
    );

    _themeService.saveThemeType(themeType.toString());
  }

  void setThemeMode(AppThemeMode themeMode) {
    state = state.copyWith(
      themeMode: themeMode,
      isSystemMode: themeMode == AppThemeMode.system,
    );

    _themeService.saveThemeMode(themeMode.toString());
  }
}

// Provider for theme services
final themePreferencesServiceProvider = Provider<IsarThemePreferencesService>((ref) {
  throw UnimplementedError('IsarThemePreferencesService provider must be overridden');
});

/// Provider for theme state
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  final themeService = ref.watch(themePreferencesServiceProvider);
  return ThemeNotifier(themeService);
});

/// Provider for current theme data
final themeDataProvider = Provider<ThemeData>((ref) {
  final themeState = ref.watch(themeProvider);
  final context = ref.read(contextProvider);
  return themeState.getThemeData(context);
});

/// Provider for accessing BuildContext
final contextProvider = Provider<BuildContext>((ref) {
  throw UnimplementedError('Context provider must be overridden');
});
