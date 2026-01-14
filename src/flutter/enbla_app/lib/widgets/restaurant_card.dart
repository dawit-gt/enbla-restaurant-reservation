// lib/widgets/restaurant_card.dart
import 'package:flutter/material.dart';
import '../models/restaurant.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final VoidCallback onTap;

  const RestaurantCard({
    super.key,
    required this.restaurant,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFE5D3C5),
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundImage: NetworkImage(restaurant.imageUrl),
                backgroundColor: const Color(0xFFCCCCCC),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  restaurant.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF4A2E2E),
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: const Color(0xFF7B3738),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
