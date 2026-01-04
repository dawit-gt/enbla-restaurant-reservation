import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


// Home
import 'screens/home/home_screen.dart';

// Auth
import 'screens/auth/role_selection_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/login_customer_screen.dart';
import 'screens/auth/login_manager_screen.dart';

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
        '/login_customer': (context) => const LoginCustomerScreen(),
        '/login_manager': (context) => const LoginManagerScreen(),
        '/register': (context) => const RegisterScreen(),
        '/customer_dashboard': (context) =>
            const CustomerDashboardScreen(),
        '/restaurants': (context) => RestaurantListScreen(),
      },

    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const EnblaApp());
}

