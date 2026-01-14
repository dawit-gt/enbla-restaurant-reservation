// lib/screens/auth/login_screen.dart
import 'package:flutter/material.dart';
import '../../widgets/text_input_field.dart';
import '../customer/customer_home_screen.dart';
import '../manager/manager_home_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _loginAsCustomer() {
    Navigator.pushReplacementNamed(context, CustomerHomeScreen.routeName);
  }

  void _loginAsManager() {
    Navigator.pushReplacementNamed(context, ManagerHomeScreen.routeName);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _stylishAction(String label, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: Colors.transparent,
        border: Border.all(color: const Color(0xFF4E2021), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 28),
            child: Center(
              child: Text(
                label,
                style: const TextStyle(
                  color: Color(0xFFD9C3A5),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF72383D),
      body: SafeArea(
        child: Stack(
          children: [
            // Top-left title
            const Positioned(
              left: 20,
              top: 24,
              child: Text(
                'Login',
                style: TextStyle(
                  color: Color(0xFFD9C3A5),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Main content
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 42),

                      // logo box that matches figma's rounded square
                      Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          color: const Color(0xFF7B3738),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: const Color(0xFF4E2021)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.35),
                              blurRadius: 10,
                              offset: const Offset(0, 6),
                            ),
                            BoxShadow(
                              color: Colors.white.withOpacity(0.02),
                              offset: const Offset(0, -2),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/images/enbla_logo.png',
                            width: 48,
                            height: 48,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                                  Icons.restaurant,
                                  size: 44,
                                  color: Colors.white,
                                ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      const Text(
                        'Welcome to Enbla',
                        style: TextStyle(
                          color: Color(0xFFD9C3A5),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 28),

                      TextInputField(
                        controller: _emailController,
                        hintText: 'Email',
                      ),

                      const SizedBox(height: 12),

                      TextInputField(
                        controller: _passwordController,
                        hintText: 'Password',
                        obscure: true,
                      ),

                      const SizedBox(height: 28),

                      // Buttons with styled container to emulate Figma's shadowed rounded buttons
                      _stylishAction('Login as Customer', _loginAsCustomer),

                      const SizedBox(height: 12),

                      _stylishAction('Login as Manager', _loginAsManager),

                      const SizedBox(height: 28),

                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SignupScreen.routeName);
                        },
                        child: const Text(
                          "Don't have an account, Signup",
                          style: TextStyle(color: Color(0xFFD9C3A5)),
                        ),
                      ),

                      const SizedBox(height: 48),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
