import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../routes/app_routes.dart';
import '../../services/auth_service.dart';
import '../../services/google_sign_in_service.dart';
import '../../services/firestore_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignup() {
    Navigator.pushNamed(context, AppRoutes.signup);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _loginAsCustomer() async {
    try {
      await AuthService().signInWithEmail(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      Navigator.pushReplacementNamed(context, AppRoutes.customerHome);
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? 'Login failed');
    } catch (e) {
      _showError('Login failed');
    }
  }

  Future<void> _loginAsManager() async {
    try {
      await AuthService().signInWithEmail(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      Navigator.pushReplacementNamed(context, AppRoutes.managerHome);
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? 'Login failed');
    } catch (e) {
      _showError('Login failed');
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final cred = await GoogleSignInService.signInWithGoogle(forSignUp: false);
      if (cred != null) {
        // Optionally, you can check if user exists in Firestore and add if new
        await FirestoreService().addCustomer(
          uid: cred.user!.uid,
          name: cred.user!.displayName ?? '',
          email: cred.user!.email ?? '',
        );
        Navigator.pushReplacementNamed(context, AppRoutes.customerHome);
      }
    } catch (e) {
      _showError('Google sign-in failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF6F3738);
    const cardColor = Color(0xFFE3D3C3);
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
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFE9D9D0),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Logo
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Color(0xFFB43D3F),
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

              const SizedBox(height: 40),

              // Email field
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: cardColor,
                  hintText: 'Email',
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
              ),
              const SizedBox(height: 16),

              // Password field
              TextField(
                controller: _passwordController,
                obscureText: true,
                style: const TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: cardColor,
                  hintText: 'Password',
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
              ),

              const SizedBox(height: 32),

              // Login as Customer button
              _LoginButton(
                label: 'Login as Customer',
                onPressed: _loginAsCustomer,
                color: primaryButtonColor,
                shadowColor: buttonShadowColor,
              ),
              const SizedBox(height: 16),

              // Login as Manager button
              _LoginButton(
                label: 'Login as Manager',
                onPressed: _loginAsManager,
                color: primaryButtonColor,
                shadowColor: buttonShadowColor,
              ),

              const SizedBox(height: 32),

              // Google Sign-In
              SizedBox(
                width: 240,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.g_mobiledata, size: 20),
                  label: const Text('Sign in with Google'),
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

              // Signup text
              GestureDetector(
                onTap: _onSignup,
                child: const Text.rich(
                  TextSpan(
                    text: "Don't have an account, ",
                    style: TextStyle(color: Color(0xFFE9D9D0), fontSize: 14),
                    children: [
                      TextSpan(
                        text: 'Signup',
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

class _LoginButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final Color shadowColor;

  const _LoginButton({
    required this.label,
    required this.onPressed,
    required this.color,
    required this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
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
