import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addReservation({
    required String reservationId,
    required String userId,
    required String restaurantId,
    required DateTime dateTime,
    int? guests,
    String? notes,
  }) async {
    await _db.collection('reservations').doc(reservationId).set({
      'userId': userId,
      'restaurantId': restaurantId,
      'dateTime': dateTime.toIso8601String(),
      'guests': guests ?? 1,
      'notes': notes ?? '',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // You can add more methods for fetching, updating, or deleting reservations as needed.
}
