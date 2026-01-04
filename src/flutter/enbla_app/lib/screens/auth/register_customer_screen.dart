import 'package:flutter/material.dart';

class RegisterCustomerScreen extends StatelessWidget {
  const RegisterCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // registration logic later
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
