import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

    final currentUser = FirebaseAuth.instance.currentUser;
    final managerId = currentUser?.uid;
    // Only show restaurants where managerId matches current user
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('restaurants')
          .where('managerId', isEqualTo: managerId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final docs = snapshot.data?.docs ?? [];
        final restaurants = docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return _ManagerRestaurantItem(
            id: doc.id,
            name: data['name'] ?? '',
            imageUrl:
                (data['photoUrl'] != null &&
                    (data['photoUrl'] as String).isNotEmpty)
                ? data['photoUrl']
                : '',
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
                      'Welcome, Manager',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
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
                              decoration: BoxDecoration(
                                color: cardColor,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                          )
                                        : Image.asset(
                                            'assets/images/enbla_logo.png',
                                            width: 120,
                                            height: 110,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  const SizedBox(width: 12),
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
                                        ],
                                      ),
                                    ),
                                  ),
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
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: () => _onAddRestaurant(context),
            backgroundColor: addButtonColor,
            tooltip: 'Add Restaurant',
            child: const Icon(Icons.add, color: Colors.white),
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
