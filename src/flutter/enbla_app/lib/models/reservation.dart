// lib/models/reservation.dart
class Reservation {
  final String id;
  final String restaurantId;
  final String userId;
  final DateTime dateTime;
  final int guests;
  final String status;

  Reservation({
    required this.id,
    required this.restaurantId,
    required this.userId,
    required this.dateTime,
    required this.guests,
    required this.status,
  });
}
