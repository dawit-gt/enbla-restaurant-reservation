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
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              TextInputField(controller: _emailController, hintText: 'Email'),
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
              const Spacer(),
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
    );
  }
}
