import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../routing/routes.dart';

class BottomNavigation extends ConsumerStatefulWidget {
  @override
  ConsumerState<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends ConsumerState<BottomNavigation> {
  var _selectedIndex = 0;

  void _handleIndexChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushNamed(context, Routes.homePage);
        break;
      case 1:
        Navigator.pushNamed(context, Routes.discoverRoutes);
        break;
      case 2:
        Navigator.pushNamed(context, Routes.personalProfile);
        break;
      case 3:
        Navigator.pushNamed(context, Routes.createEvent);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get theme data using Theme.of(context)
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _handleIndexChanged,
      backgroundColor: theme.cardColor,
      selectedItemColor: colorScheme.secondary,
      unselectedItemColor: Colors.grey[600],
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore_outlined),
          activeIcon: Icon(Icons.explore),
          label: 'Discover',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline),
          activeIcon: Icon(Icons.add_circle),
          label: 'Create',
        ),
      ],
    );
  }
}

// Mapping for navigation destinations to keep the same functionality
enum NavigationDestination {
  home,
  discover,
  profile,
  create
}
