import 'package:flutter/material.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Role'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Continue as',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login_customer');
              },
              child: Text('Customer'),
            ),

            SizedBox(height: 15),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login_manager');
              },
              child: Text('Restaurant Manager'),
            ),
          ],
        ),
      ),
    );
  }
}
