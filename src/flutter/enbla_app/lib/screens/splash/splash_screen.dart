// lib/screens/splash/splash_screen.dart
import 'dart:async';

import 'package:flutter/material.dart';
import '../auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _fadeAnim;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeIn);
    _scaleAnim = Tween<double>(begin: 0.92, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutBack),
    );

    _animController.forward();

    // Navigate after a short delay (keeps mounted safety)
    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF72383D), // painted burgundy background
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ScaleTransition(
                  scale: _scaleAnim,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: const Color(0xFF7B3738),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: const Color(0xFF4E2021),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromRGBO(0, 0, 0, 0.45),
                              blurRadius: 12,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        child: Container(
                          width: 72,
                          height: 8,
                          decoration: BoxDecoration(
                            color: const Color(0xFFB88E45),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Image.asset(
                          'assets/images/enbla_logo.png',
                          width: 64,
                          height: 64,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.restaurant,
                                size: 64,
                                color: Colors.white,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  'Enbla',
                  style: TextStyle(
                    color: const Color(0xFFD9C3A5),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    shadows: const [
                      Shadow(
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                        offset: Offset(2, 4),
                        blurRadius: 8,
                      ),
                      Shadow(
                        color: Color.fromRGBO(255, 255, 255, 0.06),
                        offset: Offset(-1, -1),
                        blurRadius: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
