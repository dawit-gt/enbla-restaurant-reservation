// lib/screens/customer/customer_restaurant_detail_screen.dart
import 'package:flutter/material.dart';
import '../../models/restaurant.dart';
import 'customer_reservation_form_screen.dart';

class CustomerRestaurantDetailScreen extends StatelessWidget {
  static const routeName = '/customer/restaurant/detail';

  const CustomerRestaurantDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurant = ModalRoute.of(context)!.settings.arguments as Restaurant;

    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
        backgroundColor: const Color(0xFF72383D),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
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
                  color: Color(0xFF4A2E2E),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                restaurant.location,
                style: const TextStyle(color: Color(0xFF4A2E2E)),
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBulletRow('Name: ${restaurant.name}'),
                  const SizedBox(height: 8),
                  _buildBulletRow('Location: ${restaurant.location}'),
                  const SizedBox(height: 8),
                  _buildBulletRow(restaurant.description),
                  const SizedBox(height: 8),
                  _buildBulletRow('Manager: ${restaurant.managerName}'),
                ],
              ),
              const SizedBox(height: 24),
              Center(
                child: PrimaryButton(
                  label: 'Make Reservation',
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      CustomerReservationFormScreen.routeName,
                      arguments: restaurant,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBulletRow(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(top: 6, right: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF7B3738),
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Color(0xFF4A2E2E)),
          ),
        ),
      ],
    );
  }
}
