import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addReservation({
    required String reservationId,
    required String userId,
    required String restaurantId,
    required String restaurantName,
    required String location,
    required String date,
    required String time,
    required DateTime dateTime,
    required String managerId,
    int? guests,
    String? notes,
  }) async {
    await _db.collection('reservations').doc(reservationId).set({
      'userId': userId,
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'location': location,
      'date': date,
      'time': time,
      'dateTime': dateTime.toIso8601String(),
      'managerId': managerId,
      'guests': guests ?? 1,
      'notes': notes ?? '',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // You can add more methods for fetching, updating, or deleting reservations as needed.
}
