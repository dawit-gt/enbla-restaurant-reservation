// lib/screens/manager/manager_home_screen.dart
import 'package:flutter/material.dart';
import '../../models/restaurant.dart';
import '../../widgets/restaurant_card.dart';
import 'manager_restaurant_detail_screen.dart';
import 'manager_add_restaurant_screen.dart';
import 'manager_profile_screen.dart';

class ManagerHomeScreen extends StatelessWidget {
  static const routeName = '/manager/home';

  const ManagerHomeScreen({super.key});

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
        name: 'Chala Restaurant',
        location: 'Bole, Addis',
        description: 'Dinner and drinks.',
        imageUrl:
            'https://images.pexels.com/photos/3731474/pexels-photo-3731474.jpeg',
        managerName: 'Chala',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final restaurants = _dummyRestaurants();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF72383D),
        elevation: 0,
        title: const Text('Enbla', style: TextStyle(color: Color(0xFFD9C3A5))),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                const Text(
                  'Hello, Manger Get',
                  style: TextStyle(color: Color(0xFFD9C3A5)),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    ManagerProfileScreen.routeName,
                  ),
                  child: const CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white,
                    child: Text(
                      'G',
                      style: TextStyle(
                        color: Color(0xFF4A2E2E),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFE5D3C5),
        selectedItemColor: const Color(0xFF4A2E2E),
        unselectedItemColor: const Color(0xFF4A2E2E),
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, ManagerProfileScreen.routeName);
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              'My Restaurants',
              style: TextStyle(
                color: Color(0xFF4A2E2E),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
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
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7B3738),
                    foregroundColor: const Color(0xFFD9C3A5),
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 20,
                    ),
                    elevation: 4,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      ManagerAddRestaurantScreen.routeName,
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Restaurants'),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
