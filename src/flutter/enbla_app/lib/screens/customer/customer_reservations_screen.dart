import 'package:flutter/material.dart';

class CustomerReservationsScreen extends StatelessWidget {
  const CustomerReservationsScreen({super.key});

  void _onBack(BuildContext context) {
    Navigator.pop(context);
  }

  void _onCancel(String id) {
    // TODO: cancel reservation in backend
  }

  @override
  Widget build(BuildContext context) {
    const headerColor = Color(0xFF6F3738);
    const cardColor = Color(0xFFE3D3C3);
    const bulletColor = Color(0xFF7F3335);
    const buttonColor = Color(0xFF7F3335);

    final reservations = [
      _CustomerReservation(
        id: '1',
        restaurantName: 'Abebe Restaurant',
        location: 'Lafto',
        date: '12/12/12',
        time: '11:30 AM',
        status: 'Confirmed',
      ),
      _CustomerReservation(
        id: '2',
        restaurantName: 'Chala Restaurant',
        location: 'Lebu',
        date: '12/12/12',
        time: '11:30 AM',
        status: 'Requested',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          Container(
            color: headerColor,
            padding:
                const EdgeInsets.only(top: 40, left: 12, right: 20, bottom: 12),
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
                Row(
                  children: const [
                    Text(
                      'Hello, Dawit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: Text(
                        'D',
                        style: TextStyle(
                          color: headerColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // List
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                children: reservations
                    .map(
                      (r) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
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
                                value: r.restaurantName,
                              ),
                              _ReservationBulletRow(
                                bulletColor: bulletColor,
                                label: 'Location',
                                value: r.location,
                              ),
                              _ReservationBulletRow(
                                bulletColor: bulletColor,
                                label: 'Date',
                                value: r.date,
                              ),
                              _ReservationBulletRow(
                                bulletColor: bulletColor,
                                label: 'Time',
                                value: r.time,
                              ),

                              // Status line
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _BulletDot(color: bulletColor),
                                  const SizedBox(width: 8),
                                  Text(
                                    r.status,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),

                              Center(
                                child: SizedBox(
                                  width: 140,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: buttonColor,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      elevation: 6,
                                      shadowColor: Colors.black45,
                                    ),
                                    onPressed: () => _onCancel(r.id),
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
                      ),
                    )
                    .toList(),
              ),
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
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
              ),
              children: [
                TextSpan(
                  text: value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
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
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
