// lib/models/restaurant.dart
class Restaurant {
  final String id;
  final String name;
  final String location;
  final String description;
  final String imageUrl;
  final String managerName;

  Restaurant({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.imageUrl,
    required this.managerName,
  });
}
