import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class ManagerHomeScreen extends StatelessWidget {
  const ManagerHomeScreen({super.key});

  void _onRestaurantTap(BuildContext context, String id) {
    Navigator.pushNamed(
      context,
      AppRoutes.managerRestaurantDetail,
      arguments: id,
    );
  }

  void _onAddRestaurant(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.managerAddRestaurant);
  }

  void _onBottomNavTap(BuildContext context, int index) {
    // 0 = home, 1 = profile
    if (index == 1) {
      Navigator.pushNamed(context, AppRoutes.managerProfile);
    }
  }

  @override
  Widget build(BuildContext context) {
    const headerColor = Color(0xFF6F3738);
    const cardColor = Color(0xFFE3D3C3);
    const addButtonColor = Color(0xFF7F3335);
    const bottomBarColor = Color(0xFFE3D3C3);

    // Temporary mock data; later replace with model + Firebase.
    final restaurants = [
      _ManagerRestaurantItem(
        id: '1',
        name: 'Abebe Restaurant',
        imageUrl:
            'https://via.placeholder.com/150', // replace with AssetImage or NetworkImage
      ),
      _ManagerRestaurantItem(
        id: '2',
        name: 'Chala Restaurant',
        imageUrl: 'https://via.placeholder.com/150',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          Container(
            color: headerColor,
            padding: const EdgeInsets.only(
              top: 40,
              left: 20,
              right: 20,
              bottom: 16,
            ),
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
                  children: [
                    const Text(
                      'Hello, Manger Get',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: Text(
                        'G',
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

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'My, Restaurants',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Restaurant list
                  ...restaurants.map(
                    (r) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GestureDetector(
                        onTap: () => _onRestaurantTap(context, r.id),
                        child: Container(
                          height: 96,
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            children: [
                              // Image
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(18),
                                  bottomLeft: Radius.circular(18),
                                ),
                                child: Image.network(
                                  r.imageUrl,
                                  width: 110,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16),

                              // Name
                              Expanded(
                                child: Text(
                                  r.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),

                              // Arrow
                              const Padding(
                                padding: EdgeInsets.only(right: 16),
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
                  ),

                  const SizedBox(height: 24),

                  // Add Restaurants button
                  Center(
                    child: SizedBox(
                      width: 220,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: addButtonColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          elevation: 8,
                          shadowColor: Colors.black54,
                        ),
                        onPressed: () => _onAddRestaurant(context),
                        icon: const Icon(Icons.add),
                        label: const Text(
                          'Add Restaurants',
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

      // Bottom navigation
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: bottomBarColor,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        currentIndex: 0,
        onTap: (i) => _onBottomNavTap(context, i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}

class _ManagerRestaurantItem {
  final String id;
  final String name;
  final String imageUrl;

  const _ManagerRestaurantItem({
    required this.id,
    required this.name,
    required this.imageUrl,
  });
}
