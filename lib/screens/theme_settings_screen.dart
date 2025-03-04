import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/theme_provider.dart';
import '../widgets/theme_switcher.dart';

class ThemeSettingsScreen extends ConsumerWidget {
  const ThemeSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appearance'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          
          // Current theme preview
          _buildThemePreview(context, themeState),
          
          const SizedBox(height: 24),
          
          // Theme switcher
          const ThemeSwitcher(),
          
          const SizedBox(height: 16),
          
          // Theme description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('About this theme', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text(
                      themeState.currentTheme.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildThemePreview(BuildContext context, ThemeState themeState) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Theme',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            themeState.currentTheme.name,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: themeState.currentTheme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          // Preview card showing theme elements
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Preview', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 16),
                  
                  // Color palette
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _colorCircle(themeState.currentTheme.primaryColor, 'Primary'),
                      _colorCircle(themeState.currentTheme.secondaryColor, 'Secondary'),
                      _colorCircle(themeState.currentTheme.accentColor, 'Accent'),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  
                  // Button examples
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {}, 
                        child: const Text('Button'),
                      ),
                      OutlinedButton(
                        onPressed: () {}, 
                        child: const Text('Button'),
                      ),
                      TextButton(
                        onPressed: () {}, 
                        child: const Text('Button'),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Form elements
                  TextField(
                    decoration: themeState.currentTheme.inputDecoration(
                      hintText: 'Text input',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Checkboxes and switches
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Checkbox(value: true, onChanged: (_) {}),
                      Checkbox(value: false, onChanged: (_) {}),
                      Switch(value: true, onChanged: (_) {}),
                      Switch(value: false, onChanged: (_) {}),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _colorCircle(Color color, String label) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 10)),
      ],
    );
  }
}
