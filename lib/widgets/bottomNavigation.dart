import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigation extends ConsumerStatefulWidget {
  @override
  ConsumerState<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends ConsumerState<BottomNavigation>
    with TickerProviderStateMixin {
  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    var anim = AnimationController(
      vsync: this,
      value: 1,
      duration: const Duration(milliseconds: 500),
    );
    
    // Get theme data using Theme.of(context)
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return DotNavigationBar(
      marginR: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      enableFloatingNavBar: false,
      backgroundColor: theme.cardColor,
      margin: EdgeInsets.only(left: 10, right: 10),
      currentIndex: _SelectedTab.values.indexOf(_selectedTab),
      dotIndicatorColor: colorScheme.secondary,
      // Using a darker grey for better visibility of unselected icons
      unselectedItemColor: Colors.grey[600],
      splashBorderRadius: 50,
      onTap: _handleIndexChanged,
      itemPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 16),
      items: [
        /// Home
        DotNavigationBarItem(
          icon: Icon(Icons.home),
          selectedColor: colorScheme.primary,
        ),

        /// map
        DotNavigationBarItem(
          icon: Icon(Icons.map),
          selectedColor: colorScheme.primary,
        ),

        /// Search
        DotNavigationBarItem(
          icon: Icon(Icons.groups),
          selectedColor: colorScheme.primary,
        ),

        /// Profile
        DotNavigationBarItem(
          icon: Icon(Icons.person),
          selectedColor: colorScheme.primary,
        ),
      ],
    );
  }
}

enum _SelectedTab { home, favorite, search, person }
