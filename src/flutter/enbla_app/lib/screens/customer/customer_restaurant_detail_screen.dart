import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../routes/app_routes.dart';

class CustomerRestaurantDetailScreen extends StatelessWidget {
  const CustomerRestaurantDetailScreen({super.key});

  void _onBack(BuildContext context) {
    Navigator.pop(context);
  }

  void _onReserveTable(
    BuildContext context,
    String restaurantId,
    String restaurantName,
    String location,
  ) {
    Navigator.pushNamed(
      context,
      AppRoutes.customerReservationForm,
      arguments: {
        'restaurantId': restaurantId,
        'restaurantName': restaurantName,
        'location': location,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const headerColor = Color(0xFF6F3738);
    const bulletColor = Color(0xFF7F3335);

    final restaurantId = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      backgroundColor: Colors.white,
      body: restaurantId == null
          ? const Center(child: Text('No restaurant selected'))
          : StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('restaurants')
                  .doc(restaurantId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Center(child: Text('Restaurant not found'));
                }
                final data = snapshot.data!.data() as Map<String, dynamic>;
                final restaurantName = data['name'] ?? '';
                final location = data['location'] ?? '';
                final description = data['description'] ?? '';
                final managerName = data['managerName'] ?? '';
                final imageUrl = data['photoUrl'] ?? '';
                return Column(
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
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => _onBack(context),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              restaurantName + '\nRestaurant',
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

                    // Image
                    SizedBox(
                      height: 190,
                      width: double.infinity,
                      child: imageUrl.isNotEmpty
                          ? Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/enbla_logo.png',
                                  fit: BoxFit.contain,
                                );
                              },
                            )
                          : Image.asset(
                              'assets/images/enbla_logo.png',
                              fit: BoxFit.contain,
                            ),
                    ),

                    // Details
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _BulletTextRow(
                              bulletColor: bulletColor,
                              label: 'Name',
                              value: restaurantName,
                              boldValue: true,
                            ),
                            const SizedBox(height: 12),
                            _BulletTextRow(
                              bulletColor: bulletColor,
                              label: 'Location',
                              value: location,
                              boldValue: true,
                            ),
                            const SizedBox(height: 12),
                            _BulletParagraph(
                              bulletColor: bulletColor,
                              text: description,
                            ),
                            const SizedBox(height: 12),
                            _BulletTextRow(
                              bulletColor: bulletColor,
                              label: 'Manager',
                              value: managerName,
                              boldValue: true,
                            ),
                            const SizedBox(height: 32),

                            // Reserve Table button
                            Center(
                              child: SizedBox(
                                width: 190,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: headerColor,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    elevation: 6,
                                    shadowColor: Colors.black45,
                                  ),
                                  onPressed: () => _onReserveTable(
                                    context,
                                    restaurantId,
                                    restaurantName,
                                    location,
                                  ),
                                  child: const Text(
                                    'Reserve Table',
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
                );
              },
            ),
    );
  }
}

class _BulletTextRow extends StatelessWidget {
  final Color bulletColor;
  final String label;
  final String value;
  final bool boldValue;

  const _BulletTextRow({
    required this.bulletColor,
    required this.label,
    required this.value,
    this.boldValue = false,
  });

  @override
  Widget build(BuildContext context) {
    final valueStyle = TextStyle(
      fontWeight: boldValue ? FontWeight.w700 : FontWeight.w400,
    );

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
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              children: [TextSpan(text: value, style: valueStyle)],
            ),
          ),
        ),
      ],
    );
  }
}

class _BulletParagraph extends StatelessWidget {
  final Color bulletColor;
  final String text;

  const _BulletParagraph({required this.bulletColor, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BulletDot(color: bulletColor),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Colors.black87, fontSize: 14),
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
