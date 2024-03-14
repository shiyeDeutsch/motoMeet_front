import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
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
    return DotNavigationBar(
    marginR : const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      
      backgroundColor: Color.fromARGB(255, 85, 78, 58),
    margin: EdgeInsets.only(left: 10, right: 10 ),
      currentIndex: _SelectedTab.values.indexOf(_selectedTab),
      dotIndicatorColor: Colors.white,
      unselectedItemColor: Colors.grey[300],
      splashBorderRadius: 50,
      // enableFloatingNavBar: false,
      onTap: _handleIndexChanged,
       itemPadding :const EdgeInsets.symmetric(vertical: 7, horizontal: 16),
      items: [
        /// Home
        DotNavigationBarItem(
          icon: Icon(Icons.home),
          selectedColor: Color.fromARGB(255, 212, 105, 78),
        ),

        /// map
        DotNavigationBarItem(
          icon: Icon(Icons.map),
          selectedColor:  Color.fromARGB(255, 212, 105, 78),
        ),

        /// Search
        DotNavigationBarItem(
          icon: Icon(Icons.groups),
          selectedColor:  Color.fromARGB(255, 212, 105, 78),
        ),

        /// Profile
        DotNavigationBarItem(
          icon: Icon(Icons.person),
          selectedColor:  Color.fromARGB(255, 212, 105, 78),
        ),
      ],
    );
  }
}

enum _SelectedTab { home, favorite, search, person }
