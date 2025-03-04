import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/theme_provider.dart';

class ThemeSwitcher extends ConsumerWidget {
  const ThemeSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Theme', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            
            // Theme selection
            Text('Select Theme', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: AppThemeType.values.map((type) {
                final isSelected = themeState.themeType == type;
                return FilterChip(
                  label: Text(_getThemeDisplayName(type)),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      ref.read(themeProvider.notifier).setTheme(type);
                    }
                  },
                  backgroundColor: isSelected 
                    ? themeState.currentTheme.primaryColor.withOpacity(0.1)
                    : null,
                  checkmarkColor: themeState.currentTheme.primaryColor,
                  selectedColor: themeState.currentTheme.primaryColor.withOpacity(0.2),
                );
              }).toList(),
            ),
            
            const SizedBox(height: 16),
            
            // Theme mode selection
            Text('Display Mode', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildThemeModeChip(
                  ref, 'Light', AppThemeMode.light, 
                  themeState.themeMode, Icons.light_mode
                ),
                _buildThemeModeChip(
                  ref, 'Dark', AppThemeMode.dark, 
                  themeState.themeMode, Icons.dark_mode
                ),
                _buildThemeModeChip(
                  ref, 'System', AppThemeMode.system, 
                  themeState.themeMode, Icons.settings_suggest
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildThemeModeChip(
    WidgetRef ref, 
    String label, 
    AppThemeMode mode, 
    AppThemeMode currentMode,
    IconData icon,
  ) {
    final isSelected = currentMode == mode;
    final themeState = ref.read(themeProvider);
    
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon, 
            size: 18, 
            color: isSelected 
              ? themeState.currentTheme.primaryColor 
              : Colors.grey,
          ),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          ref.read(themeProvider.notifier).setThemeMode(mode);
        }
      },
      backgroundColor: isSelected 
        ? themeState.currentTheme.primaryColor.withOpacity(0.1)
        : null,
      checkmarkColor: themeState.currentTheme.primaryColor,
      selectedColor: themeState.currentTheme.primaryColor.withOpacity(0.2),
    );
  }
  
  String _getThemeDisplayName(AppThemeType type) {
    switch (type) {
      case AppThemeType.adventure:
        return 'Adventure';
      case AppThemeType.modernExplorer:
        return 'Modern Explorer';
      case AppThemeType.trailMap:
        return 'Trail Map';
      case AppThemeType.communityAdventure:
        return 'Community';
      case AppThemeType.technicalEquipment:
        return 'Technical';
    }
  }
}
