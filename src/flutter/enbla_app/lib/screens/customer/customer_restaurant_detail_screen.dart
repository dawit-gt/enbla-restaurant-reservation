import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class CustomerRestaurantDetailScreen extends StatelessWidget {
  const CustomerRestaurantDetailScreen({super.key});

  void _onBack(BuildContext context) {
    Navigator.pop(context);
  }

  void _onReserveTable(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.customerReservationForm);
  }

  @override
  Widget build(BuildContext context) {
    const headerColor = Color(0xFF6F3738);
    const bulletColor = Color(0xFF7F3335);

    // For now static; later pass Restaurant through Navigator arguments.
    const restaurantName = 'Abebe Restaurant';
    const location = 'Lafto, Addis Ababa';
    const description =
        'A cozy modern restaurant serving freshly prepared local and international dishes. '
        'Known for its warm atmosphere and friendly service, perfect for casual dining or small celebrations.';
    const managerName = 'Abebe Tola';
    const imageUrl = '';

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

          // Image
          SizedBox(
            height: 190,
            width: double.infinity,
            child: Image.network(imageUrl, fit: BoxFit.cover),
          ),

          // Details
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                  _BulletParagraph(bulletColor: bulletColor, text: description),
                  const SizedBox(height: 12),
                  _BulletTextRow(
                    bulletColor: bulletColor,
                    label: 'Manger',
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
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 6,
                          shadowColor: Colors.black45,
                        ),
                        onPressed: () => _onReserveTable(context),
                        child: const Text(
                          'Reserve Table',
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
