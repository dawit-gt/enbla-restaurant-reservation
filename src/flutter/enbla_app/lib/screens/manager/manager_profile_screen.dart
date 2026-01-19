import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../routes/app_routes.dart';

class ManagerProfileScreen extends StatelessWidget {
  const ManagerProfileScreen({super.key});

  void _onReservations(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.managerReservations);
  }

  Future<void> _onLogout(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    // TODO: clear auth + navigate to login
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
  }

  void _onBottomNavTap(BuildContext context, int index) {
    // 0 = home, 1 = profile
    if (index == 0) {
      Navigator.pushNamed(context, AppRoutes.managerHome);
    }
  }

  @override
  Widget build(BuildContext context) {
    const headerColor = Color(0xFF6F3738);
    const cardColor = Color(0xFFE3D3C3);
    const buttonColor = Color(0xFF7F3335);
    const bottomBarColor = Color(0xFFE3D3C3);

    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;

    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<DocumentSnapshot>(
        stream: userId == null
            ? null
            : FirebaseFirestore.instance
                  .collection('users')
                  .doc(userId)
                  .snapshots(),
        builder: (context, snapshot) {
          String name = '';
          String email = user?.email ?? '';
          String role = 'Manager';
          String initial = '';
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.exists) {
            final data = snapshot.data!.data() as Map<String, dynamic>;
            name = data['name'] ?? '';
            email = data['email'] ?? email;
            role = data['role'] ?? 'Manager';
            initial = name.isNotEmpty ? name[0].toUpperCase() : '';
          } else if (user != null) {
            name = user.displayName ?? '';
            email = user.email ?? '';
            initial = name.isNotEmpty ? name[0].toUpperCase() : '';
          }
          return Column(
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
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enbla',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
                  child: Column(
                    children: [
                      // Avatar + name + role chip
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 36,
                            backgroundColor: cardColor,
                            child: Text(
                              initial,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: cardColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  role,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Email card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: RichText(
                          text: TextSpan(
                            text: 'Email: ',
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: email,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // Reservations row card
                      GestureDetector(
                        onTap: () => _onReservations(context),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 18,
                          ),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            children: const [
                              Expanded(
                                child: Text(
                                  'Reservations',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Icon(Icons.arrow_forward, color: Colors.brown),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Logout button
                      SizedBox(
                        width: 160,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            elevation: 6,
                            shadowColor: Colors.black45,
                          ),
                          onPressed: () => _onLogout(context),
                          child: const Text(
                            'Log out',
                            style: TextStyle(fontWeight: FontWeight.w600),
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
      // Bottom navigation
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: bottomBarColor,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        currentIndex: 1,
        onTap: (i) => _onBottomNavTap(context, i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}
