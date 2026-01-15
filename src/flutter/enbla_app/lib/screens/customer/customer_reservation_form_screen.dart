import 'package:flutter/material.dart';

class CustomerReservationFormScreen extends StatefulWidget {
  const CustomerReservationFormScreen({super.key});

  @override
  State<CustomerReservationFormScreen> createState() =>
      _CustomerReservationFormScreenState();
}

class _CustomerReservationFormScreenState
    extends State<CustomerReservationFormScreen> {
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _guestsController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _guestsController.dispose();
    super.dispose();
  }

  void _onBack() {
    Navigator.pop(context);
  }

  void _onReserve() {
    // TODO: send reservation to backend (e.g. Firebase)
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    const headerColor = Color(0xFF6F3738);
    const fieldColor = Color(0xFFE3D3C3);
    const bulletColor = Color(0xFF7F3335);

    // Later, restaurant name can be read from Navigator arguments.
    const restaurantName = 'Abebe Restaurant';

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
                  onPressed: _onBack,
                ),
                const SizedBox(width: 4),
                const Expanded(
                  child: Text(
                    'Abebe\nRestaurant',
                    style: TextStyle(
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

          // Form
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Reservation Form',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
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
                          text: const TextSpan(
                            text: 'Restaurant: ',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: restaurantName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Name field
                  _LabeledField(
                    bulletColor: bulletColor,
                    label: 'Name:',
                    child: _RoundedTextField(
                      controller: _nameController,
                      color: fieldColor,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Date field
                  _LabeledField(
                    bulletColor: bulletColor,
                    label: 'Date:',
                    child: _RoundedTextField(
                      controller: _dateController,
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
                      controller: _timeController,
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
                      controller: _guestsController,
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
                        onPressed: _onReserve,
                        child: const Text(
                          'Reserve',
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
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
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
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
