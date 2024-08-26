import 'package:flutter/material.dart';
import 'package:provider_stub/screens/login/login_screen.dart';

class Routes {
  static const String login = '/';

// Add more routes here
}


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.login:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    // case Routes.details:
    // // Pass arguments if needed
    //   final args = settings.arguments as String; // Example argument
    //   return MaterialPageRoute(builder: (_) => DetailsScreen(data: args));
    // case Routes.settings:
    //   return MaterialPageRoute(builder: (_) => SettingsScreen());
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}