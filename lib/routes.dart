import 'package:digital_itikaf/frontend/home.dart';
import 'package:flutter/material.dart';
import 'route_wrapper.dart';

class AppRoutes {
  static const String home = '/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const RouteWrapper(child: Home()),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => RouteWrapper(
            child: Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ),
          ),
        );
    }
  }
}
