import 'package:flutter/material.dart';

class CustomerDashboardScreen extends StatelessWidget {
  const CustomerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Hello, Customer 👋',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/restaurants');
              },
              child: Text('View Restaurants'),
            ),

            SizedBox(height: 15),

            ElevatedButton(
              onPressed: () {
                // reservation history later
              },
              child: Text('My Reservations'),
            ),
          ],
        ),
      ),
    );
  }
}
