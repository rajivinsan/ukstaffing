import 'package:flutter/material.dart';
import 'package:sterling/routes/screen_routes.dart';
import 'package:sterling/views/auth/professionDetail/workhistory/add_work_screen.dart';
import 'package:sterling/views/spalsh_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case ScreenRoute.splashPageRoute:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case ScreenRoute.addWorkExperiemce:
        return MaterialPageRoute(builder: (context) => const AddWorkScreen());

      default:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
    }
  }
}
