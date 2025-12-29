import 'package:flutter/material.dart';

// Screens
import 'screens/home/home_screen.dart';
import 'screens/auth/role_selection_screen.dart';
import 'screens/auth/login_customer_screen.dart';
import 'screens/auth/login_manager_screen.dart';

void main() {
  runApp(const EnblaApp());
}

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
        '/': (context) => HomeScreen(),
        '/select-role': (context) => RoleSelectionScreen(),
        '/login_customer': (context) => LoginCustomerScreen(),
        '/login_manager': (context) => LoginManagerScreen(),
      },
    );
  }
}
