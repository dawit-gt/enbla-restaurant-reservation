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
      final email = _emailController.text.trim();
      final password = _passwordController.text;
      final cred = await AuthService().signInWithEmail(
        email: email,
        password: password,
      );
      // Also sign in to Supabase Auth
      await AuthService().supabaseSignInWithEmail(email, password);
      final uid = cred.user?.uid;
      if (uid == null) {
        _showError('Login failed');
        return;
      }
      // Check if user exists in customers collection
      final customerDoc = await FirestoreService().db
          .collection('customers')
          .doc(uid)
          .get();
      if (!customerDoc.exists) {
        // User is not registered as customer
        await AuthService().signOut();
        _showError('You are not registered as a customer.');
        return;
      }
      Navigator.pushReplacementNamed(context, AppRoutes.customerHome);
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: \\${e.message}');
      _showError(e.message ?? 'Login failed');
    } catch (e) {
      print('Login error: $e');
      _showError('Login failed');
    }
  }

  Future<void> _loginAsManager() async {
    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text;
      final cred = await AuthService().signInWithEmail(
        email: email,
        password: password,
      );
      // Also sign in to Supabase Auth
      await AuthService().supabaseSignInWithEmail(email, password);
      final uid = cred.user?.uid;
      if (uid == null) {
        _showError('Login failed');
        return;
      }
      // Check if user exists in managers collection
      final managerDoc = await FirestoreService().db
          .collection('managers')
          .doc(uid)
          .get();
      if (!managerDoc.exists) {
        // User is not registered as manager
        await AuthService().signOut();
        _showError('You are not registered as a manager.');
        return;
      }
      Navigator.pushReplacementNamed(context, AppRoutes.managerHome);
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: \\${e.message}');
      _showError(e.message ?? 'Login failed');
    } catch (e) {
      print('Login error: $e');
      _showError('Login failed');
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final cred = await GoogleSignInService.signInWithGoogle(forSignUp: false);
      if (cred != null) {
        final user = cred.user;
        if (user == null) return;
        final name = user.displayName ?? '';
        final email = user.email ?? '';
        // Show role selection dialog
        final role = await showDialog<String>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Select Role'),
            content: const Text('Please choose your role:'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop('customer'),
                child: const Text('Customer'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop('manager'),
                child: const Text('Manager'),
              ),
            ],
          ),
        );
        if (role == 'manager') {
          await FirestoreService().addManager(
            uid: user.uid,
            name: name,
            email: email,
          );
          Navigator.pushReplacementNamed(context, AppRoutes.managerHome);
        } else if (role == 'customer') {
          await FirestoreService().addCustomer(
            uid: user.uid,
            name: name,
            email: email,
          );
          Navigator.pushReplacementNamed(context, AppRoutes.customerHome);
        }
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
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.asset(
                        'assets/images/enbla_logo.png',
                        fit: BoxFit.contain,
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
                    SizedBox(height: 8),
                    Text(
                      'አብረን እንብላ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
