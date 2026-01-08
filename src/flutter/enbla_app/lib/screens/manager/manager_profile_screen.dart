// lib/screens/manager/manager_profile_screen.dart
import 'package:flutter/material.dart';

class ManagerProfileScreen extends StatelessWidget {
  static const routeName = '/manager/profile';

  const ManagerProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: load real manager data
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              child: Text('G'),
            ),
            const SizedBox(height: 12),
            const Text(
              'Get Manager',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'get@example.com',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
