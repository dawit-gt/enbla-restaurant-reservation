// lib/screens/auth/signup_screen.dart
import 'package:flutter/material.dart';
import '../../widgets/text_input_field.dart';
import 'login_screen.dart';

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
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  // TODO: connect to Firebase registration
  void _signupAsCustomer() {
    // TODO: register user as customer
    Navigator.pop(context);
  }

  void _signupAsManager() {
    // TODO: register user as manager
    Navigator.pop(context);
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
            // Top-left back icon and"Signup" title
            Positioned(
              left: 16,
              top: 18,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFF7B3738),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.35),
                            blurRadius: 8,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFFD9C3A5),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Signup',
                    style: TextStyle(
                      color: Color(0xFFD9C3A5),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 56),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 24),

                      // logo
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
                          ],
                        ),
                        child: Center(
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

                      const SizedBox(height: 24),

                      TextInputField(
                        controller: _nameController,
                        hintText: 'Name',
                      ),
                      const SizedBox(height: 12),
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
                      const SizedBox(height: 12),
                      TextInputField(
                        controller: _confirmController,
                        hintText: 'Confirm Password',
                        obscure: true,
                      ),

                      const SizedBox(height: 24),

                      _stylishAction('Signup as Customer', _signupAsCustomer),
                      const SizedBox(height: 12),
                      _stylishAction('Signup as Manager', _signupAsManager),

                      const SizedBox(height: 24),

                      TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(
                          context,
                          LoginScreen.routeName,
                        ),
                        child: const Text(
                          'Already have an account, Login',
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
