import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Add a reservation
  Future<void> addReservation({
    required String reservationId,
    required String restaurantId,
    required String restaurantName,
    required String customerId,
    required String customerName,
    required String location,
    required DateTime dateTime,
    required int guestCount,
    required String status, // Use string for Firestore compatibility
    Map<String, dynamic>? extraFields,
  }) async {
    await _db.collection('reservations').doc(reservationId).set({
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'customerId': customerId,
      'customerName': customerName,
      'location': location,
      'dateTime': dateTime.toIso8601String(),
      'guestCount': guestCount,
      'status': status,
      'createdAt': FieldValue.serverTimestamp(),
      ...?extraFields,
    }, SetOptions(merge: true));
  }

  // Update reservation status
  Future<void> updateReservationStatus({
    required String reservationId,
    required String status,
  }) async {
    await _db.collection('reservations').doc(reservationId).update({
      'status': status,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Delete a reservation
  Future<void> deleteReservation(String reservationId) async {
    await _db.collection('reservations').doc(reservationId).delete();
  }

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Public getter for Firestore instance
  FirebaseFirestore get db => _db;

  Future<void> addCustomer({
    required String uid,
    required String name,
    required String email,
  }) async {
    await _db.collection('customers').doc(uid).set({
      'name': name,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> addManager({
    required String uid,
    required String name,
    required String email,
  }) async {
    await _db.collection('managers').doc(uid).set({
      'name': name,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> addRestaurant({
    required String restaurantId,
    required String name,
    required String location,
    required String managerId,
    Map<String, dynamic>? extraFields,
  }) async {
    await _db.collection('restaurants').doc(restaurantId).set({
      'name': name,
      'location': location,
      'managerId': managerId,
      'createdAt': FieldValue.serverTimestamp(),
      ...?extraFields,
    }, SetOptions(merge: true));
  }

  Future<void> deleteRestaurant(String restaurantId) async {
    await _db.collection('restaurants').doc(restaurantId).delete();
  }
}
