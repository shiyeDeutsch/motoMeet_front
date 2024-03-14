import 'package:flutter/material.dart';
import 'package:motomeetfront/screens/loginScreen.dart';
import 'package:motomeetfront/screens/singupScreen.dart';
import '../screens/homeScreen.dart';
import '../screens/mapScreen.dart';
import '../screens/step1.dart';
import 'InitialRoute.dart';
import 'routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments as Map<String, dynamic>?;
    Widget screen;
    switch (settings.name) {
      case Routes.login:
        screen = LoginScreen();
        break;
      case Routes.signUp:
        screen = SignupScreen();
        break;
      case Routes.step1:
        screen = Step1Screen(email: args!['email'], password: args['password']);
        break;
      case Routes.homePage:
        screen = MyMapWidget();
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
          body: screen),
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
