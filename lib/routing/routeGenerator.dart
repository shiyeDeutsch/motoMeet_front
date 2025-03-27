import 'package:flutter/material.dart';
import 'package:motomeetfront/providers/home_screen_provider.dart';
import 'package:motomeetfront/screens/create_event_screen.dart';
import 'package:motomeetfront/screens/discover_routes_screen.dart';
import 'package:motomeetfront/screens/loginScreen.dart';
import 'package:motomeetfront/screens/singupScreen.dart';
import '../screens/homeScreen.dart';
import '../screens/mapScreen.dart';
import '../screens/saveRouteScreen.dart';
import '../screens/routeDetailsScreen.dart';
import '../screens/step1.dart';
import '../screens/userProfileScreen.dart';
import 'InitialRoute.dart';
import 'routes.dart';
import '../screens/theme_settings_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments as Map<String, dynamic>?;
    Widget screen;
    switch (settings.name) {
      case Routes.login:
        //  screen = LoginScreen();
        screen = HomePage();
        break;
      case Routes.signUp:
        screen = SignupScreen();
        break;
      case Routes.step1:
        screen = Step1Screen(email: args!['email'], password: args['password']);
        break;
      case Routes.homePage:
        screen = HomePage();
        break;
      case Routes.discoverRoutes:
        screen = const DiscoverRoutesScreen();
        break;
      case Routes.map:
        // Special case for map - return directly without the bottom nav scaffold wrapper
        return MaterialPageRoute(
          builder: (_) =>   MapMarkerScreen(baseRoute: args?['baseRoute']),
          settings: settings,
        );
      case Routes.saveRoute:
        // Special case for save route - return directly without the bottom nav scaffold wrapper
        return MaterialPageRoute(
          builder: (_) => SaveRouteScreen(
            route: args!['Route'], 
            userRoute: args['UserRoute'],
          ),
          settings: settings,
        );
      case Routes.routeDetails:
        screen = RouteDetailsScreen(route: args!['route']);
        break;
      case Routes.themeSettings:
        screen = ThemeSettingsScreen();
        break;
      case Routes.personalProfile:
        screen = PersonalProfileScreen();
        break;
      case Routes.createEvent:
        screen = CreateEventScreen();
        break;
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
    return MaterialPageRoute(
      builder: (_) => Scaffold(
          bottomNavigationBar: Builder(
            builder: (BuildContext context) {
          return RouteService.showBottomNav(context);
            },
          ),
          body: SafeArea(child: screen)),
    );
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
