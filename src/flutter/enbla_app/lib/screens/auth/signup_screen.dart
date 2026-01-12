// lib/screens/auth/signup_screen.dart
import 'package:flutter/material.dart';
import '../../widgets/text_input_field.dart';
import '../../widgets/primary_button.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // TODO: connect to Firebase registration
  void _signupAsCustomer() {
    // TODO: register user as customer
    Navigator.pop(context);
  }

  void _signupAsManager() {
    // TODO: register user as manager
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signup')),
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
                  TextInputField(controller: _nameController, hintText: 'Name'),
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
                    label: 'Signup as Customer',
                    onPressed: _signupAsCustomer,
                  ),
                  const SizedBox(height: 12),
                  PrimaryButton(
                    label: 'Signup as Manager',
                    onPressed: _signupAsManager,
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
