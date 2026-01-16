import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'firebase_options.dart';

import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

// Screens
import 'screens/splash/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';

// Manager
import 'screens/manager/manager_home_screen.dart';
import 'screens/manager/manager_profile_screen.dart';
import 'screens/manager/manager_reservations_screen.dart';
import 'screens/manager/manager_restaurant_detail_screen.dart';
import 'screens/manager/manager_add_restaurant_screen.dart';
import 'screens/manager/manager_edit_restaurant_screen.dart';

// Customer
import 'screens/customer/customer_home_screen.dart';
import 'screens/customer/customer_profile_screen.dart';
import 'screens/customer/customer_reservations_screen.dart';
import 'screens/customer/customer_restaurant_detail_screen.dart';
import 'screens/customer/customer_reservation_form_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://pumfflmbvbmweuvkcssi.supabase.co',
    anonKey: 'sb_publishable_cm-Da9IhDXfpr_wTakM8Xw_UuENFfX-',
  );
  // Print unhandled Flutter errors to console
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    // ignore: avoid_print
    print('FlutterError: \\${details.exceptionAsString()}');
  };
  runApp(const EnblaApp());
}

class EnblaApp extends StatelessWidget {
  const EnblaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
      future: _initFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }

        if (snapshot.hasError) {
          final error = snapshot.error.toString();
          // ignore: avoid_print
          print('Firebase.initializeApp() error: $error');

          if (kIsWeb && error.contains('FirebaseOptions cannot be null')) {
            return MaterialApp(
              home: Scaffold(
                appBar: AppBar(
                  title: const Text('Firebase configuration required'),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Firebase Web configuration is missing.',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'The app is running on web but no Firebase options were provided.',
                        ),
                        SizedBox(height: 8),
                        Text('Fix options (choose one):'),
                        SizedBox(height: 8),
                        Text(
                          '1) Run the FlutterFire CLI to generate firebase_options.dart:',
                        ),
                        Text('   dart pub global activate flutterfire_cli'),
                        Text(
                          '   flutterfire configure --project <your-project-id>',
                        ),
                        SizedBox(height: 8),
                        Text(
                          '2) Or register a Web app in the Firebase Console and add a Firebase configuration.',
                        ),
                        SizedBox(height: 8),
                        Text(
                          '3) As a temporary workaround you can initialize Firebase with explicit',
                        ),
                        Text('   FirebaseOptions (see Firebase docs).'),
                        SizedBox(height: 12),
                        Text(
                          'After configuring, add the generated firebase_options.dart to lib/ and ',
                        ),
                        Text('restart the app.'),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    'Initialization error:\n$error',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        }

        return MaterialApp(
          title: 'Enbla',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: StreamBuilder<fb_auth.User?>(
            stream: fb_auth.FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              }
              if (snapshot.hasData) {
                return const CustomerHomeScreen();
              }
              return const LoginScreen();
            },
          ),
          routes: {
            // Core
            AppRoutes.login: (context) => const LoginScreen(),
            AppRoutes.signup: (context) => const SignupScreen(),

            // Manager
            AppRoutes.managerHome: (context) => const ManagerHomeScreen(),
            AppRoutes.managerProfile: (context) => const ManagerProfileScreen(),
            AppRoutes.managerReservations: (context) =>
                const ManagerReservationsScreen(),
            AppRoutes.managerRestaurantDetail: (context) =>
                const ManagerRestaurantDetailScreen(),
            AppRoutes.managerAddRestaurant: (context) =>
                const ManagerAddRestaurantScreen(),
            AppRoutes.managerEditRestaurant: (context) =>
                const ManagerEditRestaurantScreen(),

            // Customer
            AppRoutes.customerHome: (context) => const CustomerHomeScreen(),
            AppRoutes.customerProfile: (context) =>
                const CustomerProfileScreen(),
            AppRoutes.customerReservations: (context) =>
                const CustomerReservationsScreen(),
            AppRoutes.customerRestaurantDetail: (context) =>
                const CustomerRestaurantDetailScreen(),
            AppRoutes.customerReservationForm: (context) =>
                const CustomerReservationFormScreen(),
          },
        );
      },
    );
  }
}

Future<FirebaseApp> _initFirebase() async {
  try {
    // Use generated options when available. For web, DefaultFirebaseOptions.currentPlatform
    // will throw if web was not configured; we rethrow to surface a helpful UI.
    final options = DefaultFirebaseOptions.currentPlatform;
    return await Firebase.initializeApp(options: options);
  } on UnsupportedError catch (e) {
    // Repackage the error so FutureBuilder can detect and show guidance.
    throw Exception(e.message);
  } catch (e) {
    // For non-web platforms, try default initialization as a fallback.
    if (!kIsWeb) {
      return await Firebase.initializeApp();
    }
    rethrow;
  }
}
