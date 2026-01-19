import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  void _onRestaurantTap(BuildContext context, String id) {
    Navigator.pushNamed(
      context,
      AppRoutes.customerRestaurantDetail,
      arguments: id,
    );
  }

  void _onBottomNavTap(BuildContext context, int index) {
    // 0 = home, 1 = profile
    if (index == 1) {
      Navigator.pushNamed(context, AppRoutes.customerProfile);
    }
    // index == 0 => already on home; do nothing
  }

  @override
  Widget build(BuildContext context) {
    const headerColor = Color(0xFF6F3738);
    const cardColor = Color(0xFFE3D3C3);
    const bottomBarColor = Color(0xFFE3D3C3);

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('restaurants').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final docs = snapshot.data?.docs ?? [];
        final restaurants = docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return _CustomerRestaurant(
            id: doc.id,
            name: data['name'] ?? '',
            description: data['description'] ?? '',
            imageUrl: data['photoUrl'] ?? 'https://via.placeholder.com/150',
          );
        }).toList();

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
                  children: const [
                    Text(
                      'እንብላ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      'Welcome, Customer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // List of restaurants
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
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
                                      child: r.imageUrl.isNotEmpty
                                          ? Image.network(
                                              r.imageUrl,
                                              width: 120,
                                              height: 110,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                    return Image.asset(
                                                      'assets/images/enbla_logo.png',
                                                      width: 120,
                                                      height: 110,
                                                      fit: BoxFit.contain,
                                                    );
                                                  },
                                            )
                                          : Image.asset(
                                              'assets/images/enbla_logo.png',
                                              width: 120,
                                              height: 110,
                                              fit: BoxFit.contain,
                                            ),
                                    ),
                                    const SizedBox(width: 12),

                                    // Text
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
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
                                        right: 14,
                                        top: 45,
                                        bottom: 0,
                                      ),
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
            onTap: (i) => _onBottomNavTap(context, i),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
            ],
          ),
        );
      },
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
