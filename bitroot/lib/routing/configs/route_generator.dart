import 'package:bitroot/pages/pages.dart';
import 'package:bitroot/routing/configs/route_contants.dart';
import 'package:bitroot/utils/utils.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  /*
  *
  *  If want to pop all previous routes and move specific screen.
  *  Navigator.of(context).pushNamedAndRemoveUntil(RouteName.homeScreenRoute, (Route<dynamic> route) => false,);
  *
  */

  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    Constants.debugLog(RouteGenerator, "Route Name:${settings.name}");

    Constants.debugLog(RouteGenerator, "Route arguments:$args");
    switch (settings.name) {
      case '/':
        return MaterialPageRoute<dynamic>(builder: (_) => const SplashScreen());

      case RouteName.splashRoute:
        return MaterialPageRoute<dynamic>(builder: (_) => const SplashScreen());

        case RouteName.reviewScheduleRoute:
        return MaterialPageRoute<dynamic>(builder: (_) => const ReviewScheduleScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(builder: (_) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
          ),
          body: const Center(
            child: Text('ERROR'),
          ),
        ),
      );
    });
  }
}
