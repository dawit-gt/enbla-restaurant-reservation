// lib/screens/manager/manager_reservations_screen.dart
import 'package:flutter/material.dart';
import '../../models/reservation.dart';
import '../../models/restaurant.dart';

class ManagerReservationsScreen extends StatelessWidget {
  static const routeName = '/manager/reservations';

  const ManagerReservationsScreen({super.key});

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
        id: '3',
        name: 'Sunset Diner',
        location: 'Bole, Addis Ababa',
        description: 'Dinner and drinks.',
        imageUrl:
            'https://images.pexels.com/photos/262978/pexels-photo-262978.jpeg',
        managerName: 'Abebe',
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

    // Sample reservations for manager's restaurants
    final reservations = [
      Reservation(
        id: 'm1',
        restaurantId: '1',
        userId: 'customer_1',
        dateTime: DateTime.now().add(const Duration(days: 1, hours: 19)),
        guests: 3,
        status: 'Confirmed',
      ),
      Reservation(
        id: 'm2',
        restaurantId: '3',
        userId: 'customer_2',
        dateTime: DateTime.now().add(const Duration(days: 2, hours: 20)),
        guests: 5,
        status: 'Pending',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Reservations')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: reservations.isEmpty
            ? const Center(
                child: Text(
                  'No reservations yet',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : ListView.builder(
                itemCount: reservations.length,
                itemBuilder: (context, index) {
                  final res = reservations[index];
                  final restaurant = restaurantMap[res.restaurantId];
                  return Card(
                    color: const Color(0xFF72383D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      onTap: () async {
                        final result = await Navigator.pushNamed(
                          context,
                          '/manager/reservation/detail',
                          arguments: {
                            'reservation': res,
                            'restaurant': restaurant,
                          },
                        );

                        if (!context.mounted) return;

                        if (result is Map<String, dynamic>) {
                          final action = result['action'] as String?;
                          if (action != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Reservation ${res.id} $action'),
                              ),
                            );
                          }
                        }
                      },
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          restaurant?.imageUrl ?? '',
                        ),
                      ),
                      title: Text(
                        restaurant?.name ?? 'Restaurant',
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            'Customer: ${res.userId}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatDateTime(res.dateTime),
                            style: const TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Guests: ${res.guests}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                      trailing: Text(
                        res.status,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
