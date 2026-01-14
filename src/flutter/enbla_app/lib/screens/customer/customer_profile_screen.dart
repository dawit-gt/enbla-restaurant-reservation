// lib/screens/customer/customer_profile_screen.dart
import 'package:flutter/material.dart';

import '../auth/login_screen.dart';

class CustomerProfileScreen extends StatelessWidget {
  static const routeName = '/customer/profile';

  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: load real customer data
    return Scaffold(
      appBar: AppBar(title: const Text('Enbla'), backgroundColor: const Color(0xFF72383D)),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 12),
            CircleAvatar(radius: 36, backgroundColor: const Color(0xFFE5D3C5), child: const Text('D', style: TextStyle(color: Color(0xFF4A2E2E)))),
            const SizedBox(height: 12),
            const Text(
              'Dawit Tadele',
              style: TextStyle(
                color: Color(0xFF4A2E2E),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFE5D3C5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Customer',
                style: TextStyle(
                  color: Color(0xFF4A2E2E),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFE5D3C5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('Email: dawit@example.com', style: TextStyle(color: Color(0xFF4A2E2E))),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () => Navigator.pushNamed(context, CustomerReservationsScreen.routeName),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5D3C5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Reservations', style: TextStyle(color: Color(0xFF4A2E2E))),
                    Icon(Icons.arrow_forward_ios, size: 18, color: Color(0xFF4A2E2E)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            PrimaryButton(label: 'Log out', onPressed: () async {
              final shouldLogout = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Logout'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Are you sure you want to log out?'),
                      const SizedBox(height: 12),
                      Center(
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Logout'),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Cancel'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
              if (shouldLogout == true) {
                if (!context.mounted) return;
                Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
              }
            }),
          ],
        ),
      ),
    );
  }
}
