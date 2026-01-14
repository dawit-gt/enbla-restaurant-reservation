// lib/screens/manager/manager_restaurant_detail_screen.dart
import 'package:flutter/material.dart';
import '../../models/restaurant.dart';
import 'manager_edit_restaurant_screen.dart';

class ManagerRestaurantDetailScreen extends StatelessWidget {
  static const routeName = '/manager/restaurant/detail';

  const ManagerRestaurantDetailScreen({super.key});

  Widget _buildBulletRow(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(top: 6, right: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF7B3738),
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(text, style: const TextStyle(color: Color(0xFF4A2E2E))),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final restaurant = ModalRoute.of(context)!.settings.arguments as Restaurant;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF72383D),
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                margin: const EdgeInsets.only(left: 12),
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFF7B3738),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.35),
                      blurRadius: 8,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(Icons.arrow_back, color: Color(0xFFD9C3A5)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                restaurant.name,
                style: const TextStyle(
                  color: Color(0xFFD9C3A5),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            const Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Row(
                children: [
                  Text(
                    'Hello, Manager Get',
                    style: TextStyle(color: Color(0xFFD9C3A5)),
                  ),
                  SizedBox(width: 8),
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: Text(
                      'G',
                      style: TextStyle(
                        color: Color(0xFF4A2E2E),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // image banner with a subtle border
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.blueAccent, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  restaurant.imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBulletRow('Name: ${restaurant.name}'),
                  const SizedBox(height: 12),
                  _buildBulletRow('Location: ${restaurant.location}'),
                  const SizedBox(height: 12),
                  _buildBulletRow(restaurant.description),
                  const SizedBox(height: 12),
                  _buildBulletRow('Manager: ${restaurant.managerName}'),
                ],
              ),
            ),

            const SizedBox(height: 24),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7B3738),
                    foregroundColor: const Color(0xFFD9C3A5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 30,
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      ManagerEditRestaurantScreen.routeName,
                      arguments: restaurant,
                    );
                  },
                  child: const Text('Update'),
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
