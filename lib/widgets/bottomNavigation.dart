import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../routing/routes.dart';

class BottomNavigation extends ConsumerStatefulWidget {
  @override
  ConsumerState<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends ConsumerState<BottomNavigation> {
  int _selectedIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateSelectedIndex();
  }

  void _updateSelectedIndex() {
    final String? currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute == Routes.homePage) {
      setState(() => _selectedIndex = 0);
    } else if (currentRoute == Routes.discoverRoutes) {
      setState(() => _selectedIndex = 1);
    } else if (currentRoute == Routes.map) {
      setState(() => _selectedIndex = 2);
    } else if (currentRoute == Routes.personalProfile) {
      setState(() => _selectedIndex = 3);
    } else if (currentRoute == Routes.createEvent) {
      setState(() => _selectedIndex = 4);
    }
  }

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
        Navigator.pushNamed(context, Routes.map);
        break;
      case 3:
        Navigator.pushNamed(context, Routes.personalProfile);
        break;
      case 4:
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
      type: BottomNavigationBarType.fixed, // Required for more than 4 items
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
          icon: Icon(Icons.map_outlined),
          activeIcon: Icon(Icons.map),
          label: 'Map',
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
  map,
  profile,
  create
}
