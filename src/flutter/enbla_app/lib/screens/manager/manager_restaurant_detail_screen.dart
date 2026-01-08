// lib/screens/manager/manager_restaurant_detail_screen.dart
import 'package:flutter/material.dart';
import '../../models/restaurant.dart';
import 'manager_edit_restaurant_screen.dart';

class ManagerRestaurantDetailScreen extends StatelessWidget {
  static const routeName = '/manager/restaurant/detail';

  const ManagerRestaurantDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final restaurant =
        ModalRoute.of(context)!.settings.arguments as Restaurant;

    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                restaurant.imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              restaurant.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              restaurant.location,
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFE5D3C5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                restaurant.description,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  ManagerEditRestaurantScreen.routeName,
                  arguments: restaurant,
                );
              },
              child: const Text('Edit Restaurant'),
            ),
          ],
        ),
      ),
    );
  }
}
