import 'package:bitroot/routing/configs/route_contants.dart';
import 'package:bitroot/utils/components/global.dart';
import 'package:flutter/services.dart';


class NavigationRoutes {
  NavigationRoutes._();

/*
 // Push a new route onto the navigation stack
  context.go('/newRoute');

// Replace the current route with a new route
  context.go('/newRoute', replaceCurrent: true);

// Pop the current route from the navigation stack
  context.pop();

// Pop until a specific route is reached
  context.popUntil((state) => state.name == '/stopRoute');

// Push a new route onto the navigation stack and remove all previous routes
  context.go('/newRoute');
  context.popUntil((state) => state.name == '/newRoute');

// Replace the current route with a new route
  context.go('/newRoute', replaceCurrent: true);
  */

  factory NavigationRoutes.getInstance() => _instance;
  static final NavigationRoutes _instance = NavigationRoutes._();

  goBack() {
    navigatorKey.currentState!.pop();
  }

  goBackToExitApp() {
    try {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    } catch (e) {
      SystemNavigator.pop();
    }
  }

  navigateToReviewSchedulePage() {
    navigatorKey.currentState!
        .pushNamedAndRemoveUntil(RouteName.reviewScheduleRoute, (route) => false);
  }
}
