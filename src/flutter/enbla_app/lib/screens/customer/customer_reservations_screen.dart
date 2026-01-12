// lib/screens/customer/customer_reservations_screen.dart
import 'package:flutter/material.dart';

class CustomerReservationsScreen extends StatelessWidget {
  static const routeName = '/customer/reservations';

  const CustomerReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: show customer reservations from Firestore
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Reservations'),
      ),
      body: const Center(
        child: Text(
          'Reservation history coming soon',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
