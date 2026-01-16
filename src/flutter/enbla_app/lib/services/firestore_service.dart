import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

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

  // Add more methods as needed (get, update, delete)
}
