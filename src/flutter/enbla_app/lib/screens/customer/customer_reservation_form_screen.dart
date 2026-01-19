import 'package:flutter/material.dart';
import '../../services/reservation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerReservationFormScreen extends StatefulWidget {
  const CustomerReservationFormScreen({super.key});

  @override
  State<CustomerReservationFormScreen> createState() =>
      _CustomerReservationFormScreenState();
}

class _CustomerReservationFormScreenState
    extends State<CustomerReservationFormScreen> {
  String? _managerName;
  String? _restaurantName;
  String? _location;
  String? _restaurantId;

  final nameController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final guestsController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    _restaurantId = args?['restaurantId'] ?? '';
    _restaurantName = args?['restaurantName'];
    _location = args?['location'] ?? '';
    if (_restaurantId != null && _restaurantId!.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('restaurants')
          .doc(_restaurantId)
          .get()
          .then((doc) async {
            final data = doc.data();
            setState(() {
              if (data != null) {
                if (_restaurantName == null || _restaurantName!.isEmpty) {
                  _restaurantName = data['name'] ?? '';
                }
                if (data['managerId'] != null) {
                  final managerId = data['managerId'];
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(managerId)
                      .get()
                      .then((userDoc) {
                        setState(() {
                          _managerName = userDoc.data()?['name'] ?? 'Unknown';
                        });
                      });
                }
              }
            });
          });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    dateController.dispose();
    timeController.dispose();
    guestsController.dispose();
    super.dispose();
  }

  void onBack() {
    Navigator.pop(context);
  }

  Future<void> onReserve() async {
    // Validate all fields
    final name = nameController.text.trim();
    final date = dateController.text.trim();
    final time = timeController.text.trim();
    final guestsText = guestsController.text.trim();
    if (name.isEmpty || date.isEmpty || time.isEmpty || guestsText.isEmpty) {
      String missing = '';
      if (name.isEmpty) missing += 'Name, ';
      if (date.isEmpty) missing += 'Date, ';
      if (time.isEmpty) missing += 'Time, ';
      if (guestsText.isEmpty) missing += 'No of guests, ';
      if (missing.endsWith(', ')) {
        missing = missing.substring(0, missing.length - 2);
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please fill in: $missing')));
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Reservation'),
        content: const Text(
          'Are you sure you want to reserve this restaurant?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be logged in to reserve.')),
      );
      return;
    }
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final restaurantId = args?['restaurantId'] ?? '';
    final restaurantName = args?['restaurantName'] ?? '';
    final location = args?['location'] ?? '';
    final reservationId = DateTime.now().millisecondsSinceEpoch.toString();
    final guests = int.tryParse(guestsText) ?? 1;
    DateTime? dateTime;
    String managerId = '';
    // Fetch managerId from restaurant document
    if (restaurantId.isNotEmpty) {
      final restaurantDoc = await FirebaseFirestore.instance
          .collection('restaurants')
          .doc(restaurantId)
          .get();
      managerId = restaurantDoc.data()?['managerId'] ?? '';
    }
    try {
      dateTime = DateTime.parse('${date.split('/').reversed.join('-')}T$time');
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid date or time format.')),
      );
      return;
    }
    await ReservationService().addReservation(
      reservationId: reservationId,
      userId: user.uid,
      restaurantId: restaurantId,
      restaurantName: restaurantName,
      location: location,
      date: date,
      time: time,
      dateTime: dateTime,
      managerId: managerId,
      guests: guests,
    );
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Reservation successful!')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    const headerColor = Color(0xFF6F3738);
    const fieldColor = Color(0xFFE3D3C3);
    const bulletColor = Color(0xFF7F3335);

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
                  onPressed: onBack,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    (_restaurantName ?? 'Restaurant'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                ),
                Row(
                  children: const [
                    Text(
                      'Hello, Customer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Form
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Reservation Form',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 24),

                  // Restaurant label
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _BulletDot(color: bulletColor),
                      const SizedBox(width: 8),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: 'Restaurant: ',
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: _restaurantName ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Name field
                  _LabeledField(
                    bulletColor: bulletColor,
                    label: 'Name:',
                    child: _RoundedTextField(
                      controller: nameController,
                      color: fieldColor,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Date field
                  _LabeledField(
                    bulletColor: bulletColor,
                    label: 'Date:',
                    child: _RoundedTextField(
                      controller: dateController,
                      color: fieldColor,
                      hintText: 'DD/MM/YY',
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Time field
                  _LabeledField(
                    bulletColor: bulletColor,
                    label: 'Time:',
                    child: _RoundedTextField(
                      controller: timeController,
                      color: fieldColor,
                      hintText: 'HH:MM',
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Guests field
                  _LabeledField(
                    bulletColor: bulletColor,
                    label: 'No of guests:',
                    child: _RoundedTextField(
                      controller: guestsController,
                      color: fieldColor,
                      keyboardType: TextInputType.number,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Reserve button
                  Center(
                    child: SizedBox(
                      width: 160,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: headerColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 6,
                          shadowColor: Colors.black45,
                        ),
                        onPressed: onReserve,
                        child: const Text(
                          'Reserve',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  final Color bulletColor;
  final String label;
  final Widget child;

  const _LabeledField({
    required this.bulletColor,
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _BulletDot(color: bulletColor),
        const SizedBox(width: 8),
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: child),
      ],
    );
  }
}

class _RoundedTextField extends StatelessWidget {
  final TextEditingController controller;
  final Color color;
  final TextInputType? keyboardType;
  final String? hintText;

  const _RoundedTextField({
    required this.controller,
    required this.color,
    this.keyboardType,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        filled: true,
        fillColor: color,
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
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
      margin: const EdgeInsets.only(top: 4),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
