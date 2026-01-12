import 'package:flutter/material.dart';
import '../screens/customer/customer_home_screen.dart';
import '../screens/auth/login_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const CustomerHomeScreen(),
    login: (context) => const LoginScreen(),
  };
}
