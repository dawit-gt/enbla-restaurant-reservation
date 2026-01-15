import 'package:flutter/material.dart';

import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

// Screens
import 'screens/splash/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';

// Manager
import 'screens/manager/manager_home_screen.dart';
import 'screens/manager/manager_profile_screen.dart';
import 'screens/manager/manager_reservations_screen.dart';
import 'screens/manager/manager_restaurant_detail_screen.dart';
import 'screens/manager/manager_add_restaurant_screen.dart';
import 'screens/manager/manager_edit_restaurant_screen.dart';

// Customer
import 'screens/customer/customer_home_screen.dart';
import 'screens/customer/customer_profile_screen.dart';
import 'screens/customer/customer_reservations_screen.dart';
import 'screens/customer/customer_restaurant_detail_screen.dart';
import 'screens/customer/customer_reservation_form_screen.dart';

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
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      routes: {
        // Core
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.signup: (context) => const SignupScreen(),

        // Manager
        AppRoutes.managerHome: (context) => const ManagerHomeScreen(),
        AppRoutes.managerProfile: (context) => const ManagerProfileScreen(),
        AppRoutes.managerReservations: (context) =>
            const ManagerReservationsScreen(),
        AppRoutes.managerRestaurantDetail: (context) =>
            const ManagerRestaurantDetailScreen(),
        AppRoutes.managerAddRestaurant: (context) =>
            const ManagerAddRestaurantScreen(),
        AppRoutes.managerEditRestaurant: (context) =>
            const ManagerEditRestaurantScreen(),

        // Customer
        AppRoutes.customerHome: (context) => const CustomerHomeScreen(),
        AppRoutes.customerProfile: (context) =>
            const CustomerProfileScreen(),
        AppRoutes.customerReservations: (context) =>
            const CustomerReservationsScreen(),
        AppRoutes.customerRestaurantDetail: (context) =>
            const CustomerRestaurantDetailScreen(),
        AppRoutes.customerReservationForm: (context) =>
            const CustomerReservationFormScreen(),
      },
    );
  }
}
