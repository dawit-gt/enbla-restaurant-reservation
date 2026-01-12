// lib/screens/customer/customer_reservation_form_screen.dart
import 'package:flutter/material.dart';
import '../../models/restaurant.dart';
import '../../widgets/primary_button.dart';

class CustomerReservationFormScreen extends StatefulWidget {
  static const routeName = '/customer/reservation/form';

  const CustomerReservationFormScreen({super.key});

  @override
  State<CustomerReservationFormScreen> createState() =>
      _CustomerReservationFormScreenState();
}

class _CustomerReservationFormScreenState
    extends State<CustomerReservationFormScreen> {
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _guestsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final restaurant =
        ModalRoute.of(context)!.settings.arguments as Restaurant;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservation'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                restaurant.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _dateController,
                decoration: const InputDecoration(
                  hintText: 'Date (e.g., 2026-01-08)',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _timeController,
                decoration: const InputDecoration(
                  hintText: 'Time (e.g., 19:30)',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _guestsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Number of guests',
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: 'Confirm Reservation',
                onPressed: () {
                  // TODO: save reservation to Firestore
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
