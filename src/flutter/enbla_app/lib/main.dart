// lib/main.dart
import 'package:flutter/material.dart';

import 'theme/app_theme.dart';

// Splash
import 'screens/splash/splash_screen.dart';

// Auth
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';

// Manager
import 'screens/manager/manager_home_screen.dart';
import 'screens/manager/manager_restaurant_detail_screen.dart';
import 'screens/manager/manager_edit_restaurant_screen.dart';
import 'screens/manager/manager_add_restaurant_screen.dart';
import 'screens/manager/manager_profile_screen.dart';
import 'screens/manager/manager_reservations_screen.dart';

// Customer
import 'screens/customer/customer_home_screen.dart';
import 'screens/customer/customer_restaurant_detail_screen.dart';
import 'screens/customer/customer_reservation_form_screen.dart';
import 'screens/customer/customer_profile_screen.dart';
import 'screens/customer/customer_reservations_screen.dart';

void main() {
  runApp(const EnblaApp());
}

class EnblaApp extends StatelessWidget {
  const EnblaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enbla',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (_) => const SplashScreen(),
        LoginScreen.routeName: (_) => const LoginScreen(),
        SignupScreen.routeName: (_) => const SignupScreen(),

        ManagerHomeScreen.routeName: (_) => const ManagerHomeScreen(),
        ManagerRestaurantDetailScreen.routeName: (_) =>
            const ManagerRestaurantDetailScreen(),
        ManagerEditRestaurantScreen.routeName: (_) =>
            const ManagerEditRestaurantScreen(),
        ManagerAddRestaurantScreen.routeName: (_) =>
            const ManagerAddRestaurantScreen(),
        ManagerProfileScreen.routeName: (_) => const ManagerProfileScreen(),
        ManagerReservationsScreen.routeName: (_) =>
            const ManagerReservationsScreen(),

        CustomerHomeScreen.routeName: (_) => const CustomerHomeScreen(),
        CustomerRestaurantDetailScreen.routeName: (_) =>
            const CustomerRestaurantDetailScreen(),
        CustomerReservationFormScreen.routeName: (_) =>
            const CustomerReservationFormScreen(),
        CustomerProfileScreen.routeName: (_) => const CustomerProfileScreen(),
        CustomerReservationsScreen.routeName: (_) =>
            const CustomerReservationsScreen(),
      },
    );
  }
}
