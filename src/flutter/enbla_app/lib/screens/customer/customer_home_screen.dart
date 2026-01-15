import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  void _onRestaurantTap(BuildContext context, String id) {
    Navigator.pushNamed(context, AppRoutes.customerRestaurantDetail, arguments: id);
  }

  void _onBottomNavTap(int index) {
    // 0 = home, 1 = profile
    // no BuildContext here; do nothing. Bottom nav wiring handled via callbacks where needed.
  }

  @override
  Widget build(BuildContext context) {
    const headerColor = Color(0xFF6F3738);
    const cardColor = Color(0xFFE3D3C3);
    const bottomBarColor = Color(0xFFE3D3C3);

    final restaurants = [
      _CustomerRestaurant(
        id: '1',
        name: 'Abebe Restaurant',
        description:
            'A cozy modern restaurant serving freshly prepared local and international dishes. Known for its warm atmosphere and friendly service, ideal for evening meals and celebrations.',
        imageUrl: 'https://via.placeholder.com/160',
      ),
      _CustomerRestaurant(
        id: '2',
        name: 'Chala Restaurant',
        description:
            'A contemporary dining spot blending grilled flavors with classic recipes. Perfect for relaxed conversations and memorable table reservations.',
        imageUrl: 'https://via.placeholder.com/160',
      ),
      _CustomerRestaurant(
        id: '3',
        name: 'Dawit Restaurant',
        description:
            'A stylish restaurant offering simple, flavorful meals made with fresh ingredients. Great for quick lunches and relaxed dinners.',
        imageUrl: 'https://via.placeholder.com/160',
      ),
      _CustomerRestaurant(
        id: '4',
        name: 'Tadele Restaurant',
        description:
            'An elegant restaurant focused on quality and comfort. Popular for family dinners and special occasions.',
        imageUrl: 'https://via.placeholder.com/160',
      ),
      _CustomerRestaurant(
        id: '5',
        name: 'Terefe Restaurant',
        description:
            'A casual dining restaurant featuring light meals and comforting flavors, with easy table booking.',
        imageUrl: 'https://via.placeholder.com/160',
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
                const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Enbla',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: const [
                    Text(
                      'Hello, Dawit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
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

          // List of restaurants
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: restaurants
                    .map(
                      (r) => Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: GestureDetector(
                          onTap: () => _onRestaurantTap(context, r.id),
                          child: Container(
                            decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(18),
                                    bottomLeft: Radius.circular(18),
                                  ),
                                  child: Image.network(
                                    r.imageUrl,
                                    width: 120,
                                    height: 110,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 12),

                                // Text
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          r.name,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          r.description,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // Arrow
                                const Padding(
                                  padding: EdgeInsets.only(
                                      right: 14, top: 45, bottom: 0),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.brown,
                                  ),
                                ),
                              ],
                            ),
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

      // Bottom navigation
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: bottomBarColor,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        currentIndex: 0,
        onTap: _onBottomNavTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}

class _CustomerRestaurant {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  const _CustomerRestaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });
}
