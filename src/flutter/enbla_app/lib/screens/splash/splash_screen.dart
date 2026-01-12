// lib/screens/splash/splash_screen.dart
import 'package:flutter/material.dart';
import '../auth/login_screen.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/';

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.restaurant, size: 80, color: Colors.white),
            SizedBox(height: 16),
            Text(
              'Enbla',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
