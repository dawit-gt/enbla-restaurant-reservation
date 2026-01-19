import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'firebase_options.dart';

import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

// Screens
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

// Splash
import 'screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://ifenzgestzrabemjqdum.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlmZW56Z2VzdHpyYWJlbWpxZHVtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg1Nzc2MjAsImV4cCI6MjA4NDE1MzYyMH0.cxpLb_6NIQWgTEI-OuoeT-1CNXxCYv566JN7ag7oNE8',
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
          // Show simple splash screen (no navigation) while initializing
          return MaterialApp(
            debugShowCheckedModeBanner: false,
          );
        }

        if (snapshot.hasError) {
          final error = snapshot.error.toString();
          // ignore: avoid_print
          print('Firebase.initializeApp() error: $error');
          return MaterialApp(
            initialRoute: '/error',
            routes: {
              '/error': (context) => Scaffold(
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
            },
            debugShowCheckedModeBanner: false,
          );
        }

        // Firebase initialized, show splash then navigate to login
        print(
          'EnblaApp: Firebase initialized, building MaterialApp with SplashScreen',
        );
        return MaterialApp(
          title: 'Enbla',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          initialRoute: '/',
          routes: {
            // Core
            '/': (context) => SplashScreen(),
            AppRoutes.login: (context) => LoginScreen(),
            AppRoutes.signup: (context) => SignupScreen(),

            // Manager
            AppRoutes.managerHome: (context) => ManagerHomeScreen(),
            AppRoutes.managerProfile: (context) => ManagerProfileScreen(),
            AppRoutes.managerReservations: (context) =>
                ManagerReservationsScreen(),
            AppRoutes.managerRestaurantDetail: (context) =>
                ManagerRestaurantDetailScreen(),
            AppRoutes.managerAddRestaurant: (context) =>
                ManagerAddRestaurantScreen(),
            AppRoutes.managerEditRestaurant: (context) =>
                ManagerEditRestaurantScreen(),

            // Customer
            AppRoutes.customerHome: (context) => CustomerHomeScreen(),
            AppRoutes.customerProfile: (context) => CustomerProfileScreen(),
            AppRoutes.customerReservations: (context) =>
                CustomerReservationsScreen(),
            AppRoutes.customerRestaurantDetail: (context) =>
                CustomerRestaurantDetailScreen(),
            AppRoutes.customerReservationForm: (context) =>
                CustomerReservationFormScreen(),
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
