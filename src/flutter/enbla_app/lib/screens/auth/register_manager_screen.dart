import 'package:flutter/material.dart';

class RegisterManagerScreen extends StatelessWidget {
  const RegisterManagerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manager Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Restaurant Name'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Manager Name'),
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
