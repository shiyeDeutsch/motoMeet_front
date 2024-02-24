import 'package:flutter/material.dart';
import 'package:motomeetfront/screens/loginScreen.dart';
import 'package:motomeetfront/screens/singupScreen.dart';
import '../screens/homeScreen.dart';
import '../screens/step1.dart';
import 'routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final  args = settings.arguments as Map<String, dynamic>?;
    Widget Function(BuildContext) screen;
    switch (settings.name) {
      case Routes.login:
        screen = (_) =>   LoginScreen();
        break;
      case Routes.signUp:
        screen = (_) =>   SignupScreen(
         
        );
        break;
         case Routes.step1:
        screen = (_) =>   Step1Screen( 
             email: args! ['email']  ,
          password:args['password']);
        break;
        // Validation of correct data type
      //  if (args is String) {}
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
      //  return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
    return MaterialPageRoute(builder: screen);
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
