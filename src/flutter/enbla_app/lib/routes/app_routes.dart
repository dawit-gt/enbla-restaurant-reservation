import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
import '../screens/auth/login_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
    login: (context) => const LoginScreen(),
  };
}
