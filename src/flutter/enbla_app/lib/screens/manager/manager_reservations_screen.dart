// lib/screens/manager/manager_reservations_screen.dart
import 'package:flutter/material.dart';

class ManagerReservationsScreen extends StatelessWidget {
  static const routeName = '/manager/reservations';

  const ManagerReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: show reservations for manager restaurant
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservations'),
      ),
      body: const Center(
        child: Text(
          'Reservation list coming soon',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
