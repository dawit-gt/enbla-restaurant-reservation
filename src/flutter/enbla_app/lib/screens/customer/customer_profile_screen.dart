// lib/screens/customer/customer_profile_screen.dart
import 'package:flutter/material.dart';

class CustomerProfileScreen extends StatelessWidget {
  static const routeName = '/customer/profile';

  const CustomerProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: load real customer data
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            CircleAvatar(
              radius: 40,
              child: Text('D'),
            ),
            SizedBox(height: 12),
            Text(
              'Dawit Tadele',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'dawit@example.com',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
