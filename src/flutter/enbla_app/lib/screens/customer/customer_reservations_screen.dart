// lib/screens/customer/customer_reservations_screen.dart
import 'package:flutter/material.dart';
import '../../models/reservation.dart';
import '../../models/restaurant.dart';

class CustomerReservationsScreen extends StatelessWidget {
  static const routeName = '/customer/reservations';

  const CustomerReservationsScreen({super.key});

  List<Restaurant> _dummyRestaurants() {
    return [
      Restaurant(
        id: '1',
        name: 'Abebe Restaurant',
        location: 'Addis Ababa',
        description: 'Local dishes and more.',
        imageUrl:
            'https://images.pexels.com/photos/262978/pexels-photo-262978.jpeg',
        managerName: 'Abebe',
      ),
      Restaurant(
        id: '2',
        name: 'Lideta Cafe',
        location: 'Lideta, Addis Ababa',
        description: 'Coffee and snacks.',
        imageUrl:
            'https://images.pexels.com/photos/3731474/pexels-photo-3731474.jpeg',
        managerName: 'Saron',
      ),
    ];
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final restaurants = _dummyRestaurants();
    final restaurantMap = {for (var r in restaurants) r.id: r};

    // Two sample reservations
    final reservations = [
      Reservation(
        id: 'r1',
        restaurantId: '1',
        userId: 'u1',
        dateTime: DateTime.now().add(const Duration(days: 3, hours: 19)),
        guests: 2,
        status: 'Confirmed',
      ),
      Reservation(
        id: 'r2',
        restaurantId: '2',
        userId: 'u1',
        dateTime: DateTime.now().add(const Duration(days: 7, hours: 20)),
        guests: 4,
        status: 'Pending',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('My Reservations'), backgroundColor: const Color(0xFF72383D)),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: reservations.isEmpty
            ? const Center(
                child: Text(
                  'No reservations found',
                  style: TextStyle(color: Color(0xFF4A2E2E)),
                ),
              )
            : ListView.builder(
                itemCount: reservations.length,
                itemBuilder: (context, index) {
                  final res = reservations[index];
                  final restaurant = restaurantMap[res.restaurantId];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5D3C5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant?.name ?? 'Restaurant',
                          style: const TextStyle(
                              color: Color(0xFF4A2E2E), fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Date: ${_formatDateTime(res.dateTime)}',
                          style: const TextStyle(color: Color(0xFF4A2E2E)),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Guests: ${res.guests}',
                          style: const TextStyle(color: Color(0xFF4A2E2E)),
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: PrimaryButton(label: 'View', onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/customer/reservation/detail',
                              arguments: {
                                'reservation': res,
                                'restaurant': restaurant,
                              },
                            );
                          }),
                        )
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
