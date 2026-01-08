// lib/screens/customer/customer_home_screen.dart
import 'package:flutter/material.dart';
import '../../models/restaurant.dart';
import '../../widgets/restaurant_card.dart';
import 'customer_restaurant_detail_screen.dart';
import 'customer_profile_screen.dart';
import 'customer_reservations_screen.dart';

class CustomerHomeScreen extends StatelessWidget {
  static const routeName = '/customer/home';

  const CustomerHomeScreen({Key? key}) : super(key: key);

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
              Navigator.pushNamed(context, CustomerProfileScreen.routeName);
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'My Reservations',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(
                context, CustomerReservationsScreen.routeName);
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Restaurants',
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
                        CustomerRestaurantDetailScreen.routeName,
                        arguments: restaurant,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
