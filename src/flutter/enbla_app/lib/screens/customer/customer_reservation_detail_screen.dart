// lib/screens/customer/customer_reservation_detail_screen.dart
import 'package:flutter/material.dart';
import '../../models/reservation.dart';
import '../../models/restaurant.dart';

class CustomerReservationDetailScreen extends StatelessWidget {
  static const routeName = '/customer/reservation/detail';

  const CustomerReservationDetailScreen({super.key});

  String _formatDateTime(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Reservation res = args['reservation'] as Reservation;
    final Restaurant? restaurant = args['restaurant'] as Restaurant?;

    return Scaffold(
      appBar: AppBar(title: const Text('Reservation Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (restaurant != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  restaurant.imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                restaurant.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                restaurant.location,
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 12),
            ],

            Card(
              color: const Color(0xFF72383D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Reservation',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Date & Time: ${_formatDateTime(res.dateTime)}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Guests: ${res.guests}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Status: ${res.status}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (res.userId.isNotEmpty) ...[
                      Text(
                        'Reservation ID: ${res.id}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Action buttons
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final shouldCancel = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Cancel Reservation'),
                      content: const Text(
                        'Are you sure you want to cancel this reservation?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('No'),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Yes, cancel'),
                        ),
                      ],
                    ),
                  );

                  if (shouldCancel == true) {
                    // TODO: perform cancellation in backend
                    if (!context.mounted) return;
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Reservation cancelled (sample).'),
                      ),
                    );
                  }
                },
                child: const Text('Cancel Reservation'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
