// lib/screens/manager/manager_reservation_detail_screen.dart
import 'package:flutter/material.dart';
import '../../models/reservation.dart';
import '../../models/restaurant.dart';

class ManagerReservationDetailScreen extends StatefulWidget {
  static const routeName = '/manager/reservation/detail';

  const ManagerReservationDetailScreen({super.key});

  @override
  State<ManagerReservationDetailScreen> createState() =>
      _ManagerReservationDetailScreenState();
}

class _ManagerReservationDetailScreenState
    extends State<ManagerReservationDetailScreen> {
  String? _status;

  String _formatDateTime(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _handleAction(String action, Reservation res) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          '${action[0].toUpperCase()}${action.substring(1)} Reservation',
        ),
        content: Text(
          'Are you sure you want to ${action.toLowerCase()} this reservation?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      if (!mounted) return;
      setState(() {
        _status = action == 'accept' ? 'Confirmed' : 'Rejected';
      });

      // Pop with result so previous screen can update or show feedback
      Navigator.of(context).pop({'reservationId': res.id, 'action': _status});
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Reservation res = args['reservation'] as Reservation;
    final Restaurant? restaurant = args['restaurant'] as Restaurant?;

    _status ??= res.status;

    return Scaffold(
      appBar: AppBar(title: const Text('Reservation')),
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
                      'Reservation Details',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'ID: ${res.id}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Customer: ${res.userId}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Date & Time: ${_formatDateTime(res.dateTime)}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Guests: ${res.guests}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Status: $_status',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () => _handleAction('accept', res),
                  child: const Text('Accept'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () => _handleAction('reject', res),
                  child: const Text('Reject'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
