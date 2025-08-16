import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/home_screen.dart';
import '../screens/map_screen.dart';
import '../screens/detail_screen.dart';
import '../screens/booking_screen.dart';
import '../screens/my_bookings_screen.dart';
import '../screens/notifications_screen.dart';
import '../models/branch.dart';

class AppRouter {
  static const splash = '/';
  static const home = '/home';
  static const map = '/map';
  static const detail = '/detail';
  static const booking = '/booking';
  static const myBookings = '/my-bookings';
  static const notifications = '/notifications';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case map:
        return MaterialPageRoute(builder: (_) => const MapScreen());
      case detail:
        final branch = settings.arguments as Branch;
        return MaterialPageRoute(builder: (_) => DetailScreen(branch: branch));
      case booking:
        final branch = settings.arguments as Branch;
        return MaterialPageRoute(builder: (_) => BookingScreen(branch: branch));
      case myBookings:
        return MaterialPageRoute(builder: (_) => const MyBookingsScreen());
      case notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
