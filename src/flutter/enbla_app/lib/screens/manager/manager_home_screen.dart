// lib/screens/manager/manager_home_screen.dart
import 'package:flutter/material.dart';
import '../../models/restaurant.dart';
import '../../widgets/restaurant_card.dart';
import 'manager_restaurant_detail_screen.dart';
import 'manager_add_restaurant_screen.dart';
import 'manager_profile_screen.dart';
import 'manager_reservations_screen.dart';

class ManagerHomeScreen extends StatelessWidget {
  static const routeName = '/manager/home';

  const ManagerHomeScreen({Key? key}) : super(key: key);

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
    ];
  }

  @override
  Widget build(BuildContext context) {
    final restaurants = _dummyRestaurants();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enbla'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, ManagerProfileScreen.routeName);
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'My Restaurants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Reservations',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(
                context, ManagerReservationsScreen.routeName);
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Restaurants',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = restaurants[index];
                  return RestaurantCard(
                    restaurant: restaurant,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ManagerRestaurantDetailScreen.routeName,
                        arguments: restaurant,
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(
                    context, ManagerAddRestaurantScreen.routeName);
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Restaurant'),
            ),
          ],
        ),
      ),
    );
  }
}
