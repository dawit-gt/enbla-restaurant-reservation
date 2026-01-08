// lib/screens/auth/signup_screen.dart
import 'package:flutter/material.dart';
import '../../widgets/text_input_field.dart';
import '../../widgets/primary_button.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';

  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // TODO: connect to Firebase registration
  void _handleSignup() {
    // For now just pop back
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Signup',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              TextInputField(
                controller: _nameController,
                hintText: 'Name',
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
                label: 'Create account',
                onPressed: _handleSignup,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
