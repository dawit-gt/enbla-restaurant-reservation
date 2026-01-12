// lib/screens/auth/login_screen.dart
import 'package:flutter/material.dart';
import '../../widgets/text_input_field.dart';
import '../../widgets/primary_button.dart';
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

  // TODO: replace with Firebase auth + real role
  void _loginAsCustomer() {
    Navigator.pushReplacementNamed(context, CustomerHomeScreen.routeName);
  }

  void _loginAsManager() {
    Navigator.pushReplacementNamed(context, ManagerHomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),
                  Image.asset(
                    'assets/images/enbla_logo.png',
                    width: 88,
                    height: 88,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.restaurant,
                      size: 64,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Welcome to Enbla\nአብረን እንብላ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextInputField(
                    controller: _emailController,
                    hintText: 'Email',
                  ),
                  const SizedBox(height: 16),
                  TextInputField(
                    controller: _passwordController,
                    hintText: 'Password',
                    obscure: true,
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    label: 'Login as Customer',
                    onPressed: _loginAsCustomer,
                  ),
                  const SizedBox(height: 12),
                  PrimaryButton(
                    label: 'Login as Manager',
                    onPressed: _loginAsManager,
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignupScreen.routeName);
                      },
                      child: const Text(
                        'Create account',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
