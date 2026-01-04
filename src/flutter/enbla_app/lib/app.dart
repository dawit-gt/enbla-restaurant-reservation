import 'package:flutter/material.dart';

// Home
import 'screens/home/home_screen.dart';

// Auth
import 'screens/auth/role_selection_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';

// Customer
import 'screens/customer/customer_dashboard_screen.dart';
import 'screens/customer/restaurant_list_screen.dart';

class EnblaApp extends StatelessWidget {
  const EnblaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enbla Restaurant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/select-role': (context) => const RoleSelectionScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/customer_dashboard': (context) =>
            const CustomerDashboardScreen(),
        '/restaurants': (context) => RestaurantListScreen(),
      },
    );
  }
}
