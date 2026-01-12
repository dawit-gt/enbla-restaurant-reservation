// lib/screens/splash/splash_screen.dart
import 'package:flutter/material.dart';
import '../auth/login_screen.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/';

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      if (!context.mounted) return;
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/enbla_logo.png',
              width: 140,
              height: 140,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.restaurant, size: 80, color: Colors.white),
            ),
            const SizedBox(height: 12),
            const Text(
              'Welcome to Enbla\nአብረን እንብላ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
