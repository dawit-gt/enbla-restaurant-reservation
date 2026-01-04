import 'package:flutter/material.dart';

class LoginManagerScreen extends StatelessWidget {
  const LoginManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manager Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Restaurant Manager Login',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 25),

            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 25),

            ElevatedButton(
              onPressed: () {
                // login logic later
              },
              child: Text('Login'),
            ),

            SizedBox(height: 10),

            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register_manager');
              },
              child: Text("Don't have an account? Register"),
            ),
          ],
        ),
      ),
    );
  }
}
