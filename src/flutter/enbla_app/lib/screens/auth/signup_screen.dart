import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../../services/google_sign_in_service.dart';
import '../../services/auth_service.dart';
import '../../services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  Future<void> _signInWithGoogle() async {
    try {
      final cred = await GoogleSignInService.signInWithGoogle(forSignUp: true);
      if (cred != null) {
        Navigator.pushReplacementNamed(context, AppRoutes.customerHome);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Google sign-in failed')));
    }
  }

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onBack() {
    Navigator.pop(context);
  }

  Future<void> _onSignupAsCustomer() async {
    await _performSignup(asManager: false);
  }

  Future<void> _onSignupAsManager() async {
    await _performSignup(asManager: true);
  }

  void _onLogin() {
    Navigator.pushNamed(context, AppRoutes.login);
  }

  Future<void> _performSignup({required bool asManager}) async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (password != _confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }
    try {
      final cred = await AuthService().signUpWithEmail(
        name: name,
        email: email,
        password: password,
      );
      final uid = cred.user?.uid;
      if (uid != null) {
        if (asManager) {
          await FirestoreService().addManager(
            uid: uid,
            name: name,
            email: email,
          );
        } else {
          await FirestoreService().addCustomer(
            uid: uid,
            name: name,
            email: email,
          );
        }
      }
      if (asManager) {
        Navigator.pushReplacementNamed(context, AppRoutes.managerHome);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.customerHome);
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? 'Signup failed')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Signup failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF6F3738);
    const primaryButtonColor = Color(0xFF7F3335);
    const buttonShadowColor = Colors.black54;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top row: back arrow + title
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFFE9D9D0),
                    ),
                    onPressed: _onBack,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Signup',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFE9D9D0),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Logo and welcome text
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFFB43D3F),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.35),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.restaurant,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Welcome to Enbla',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFE9D9D0),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Name
              _SignupTextField(controller: _nameController, hintText: 'Name'),
              const SizedBox(height: 12),

              // Email
              _SignupTextField(
                controller: _emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),

              // Password
              _SignupTextField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 12),

              // Confirm Password
              _SignupTextField(
                controller: _confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),

              const SizedBox(height: 28),

              // Google Sign-In
              SizedBox(
                width: 240,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.g_mobiledata, size: 20),
                  label: const Text('Sign up with Google'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: _signInWithGoogle,
                ),
              ),
              const SizedBox(height: 16),

              // Signup as Customer button
              _SignupButton(
                label: 'Signup as Customer',
                onPressed: _onSignupAsCustomer,
                color: primaryButtonColor,
                shadowColor: buttonShadowColor,
              ),
              const SizedBox(height: 16),

              // Signup as Manager button
              _SignupButton(
                label: 'Signup as Manager',
                onPressed: _onSignupAsManager,
                color: primaryButtonColor,
                shadowColor: buttonShadowColor,
              ),

              const SizedBox(height: 28),

              // Login text
              GestureDetector(
                onTap: _onLogin,
                child: const Text.rich(
                  TextSpan(
                    text: 'Already have an account, ',
                    style: TextStyle(color: Color(0xFFE9D9D0), fontSize: 14),
                    children: [
                      TextSpan(
                        text: 'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          color: Color(0xFFE9D9D0),
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignupTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;

  const _SignupTextField({
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    const cardColor = Color(0xFFE3D3C3);

    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        filled: true,
        fillColor: cardColor,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black45),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _SignupButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final Color shadowColor;

  const _SignupButton({
    required this.label,
    required this.onPressed,
    required this.color,
    required this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
          elevation: 8,
          shadowColor: shadowColor,
        ),
        onPressed: onPressed,
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }
}
