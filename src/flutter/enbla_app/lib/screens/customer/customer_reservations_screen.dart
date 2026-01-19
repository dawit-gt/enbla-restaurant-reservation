import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomerReservationsScreen extends StatelessWidget {
  const CustomerReservationsScreen({super.key});

  void _onBack(BuildContext context) {
    Navigator.pop(context);
  }

  Future<void> _onCancel(BuildContext context, String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Reservation'),
        content: const Text(
          'Are you sure you want to cancel this reservation?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    await FirebaseFirestore.instance.collection('reservations').doc(id).update({
      'status': 'canceled',
    });
  }

  @override
  Widget build(BuildContext context) {
    const headerColor = Color(0xFF6F3738);
    const cardColor = Color(0xFFE3D3C3);
    const bulletColor = Color(0xFF7F3335);
    const buttonColor = Color(0xFF7F3335);

    final currentUser = FirebaseAuth.instance.currentUser;
    final customerId = currentUser?.uid;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          Container(
            color: headerColor,
            padding: const EdgeInsets.only(
              top: 40,
              left: 12,
              right: 20,
              bottom: 12,
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => _onBack(context),
                ),
                const SizedBox(width: 4),
                const Text(
                  'My Reservation',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                // TODO: Replace with live customer info if needed
                const Text(
                  'Hello, Customer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // List
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('reservations')
                  .where('userId', isEqualTo: customerId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final docs = snapshot.data?.docs ?? [];
                return SingleChildScrollView(
                  child: Column(
                    children: docs.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _ReservationBulletRow(
                                bulletColor: bulletColor,
                                label: 'Restaurant',
                                value: data['restaurantName'] ?? '',
                              ),
                              _ReservationBulletRow(
                                bulletColor: bulletColor,
                                label: 'Location',
                                value: data['location'] ?? '',
                              ),
                              _ReservationBulletRow(
                                bulletColor: bulletColor,
                                label: 'Date',
                                value: data['date'] ?? '',
                              ),
                              _ReservationBulletRow(
                                bulletColor: bulletColor,
                                label: 'Time',
                                value: data['time'] ?? '',
                              ),
                              _ReservationBulletRow(
                                bulletColor: bulletColor,
                                label: 'Guests',
                                value: (data['guests']?.toString() ?? ''),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _BulletDot(color: bulletColor),
                                  const SizedBox(width: 8),
                                  Text(
                                    data['status'] ?? 'requested',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              if ((data['status'] ?? 'requested') !=
                                      'canceled' &&
                                  (data['status'] ?? 'requested') != 'rejected')
                                Center(
                                  child: SizedBox(
                                    width: 140,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: buttonColor,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        elevation: 6,
                                        shadowColor: Colors.black45,
                                      ),
                                      onPressed: () =>
                                          _onCancel(context, doc.id),
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomerReservation {
  final String id;
  final String restaurantName;
  final String location;
  final String date;
  final String time;
  final String status;

  const _CustomerReservation({
    required this.id,
    required this.restaurantName,
    required this.location,
    required this.date,
    required this.time,
    required this.status,
  });
}

class _ReservationBulletRow extends StatelessWidget {
  final Color bulletColor;
  final String label;
  final String value;

  const _ReservationBulletRow({
    required this.bulletColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BulletDot(color: bulletColor),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: '$label: ',
              style: const TextStyle(color: Colors.black87, fontSize: 14),
              children: [
                TextSpan(
                  text: value,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _BulletDot extends StatelessWidget {
  final Color color;

  const _BulletDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
