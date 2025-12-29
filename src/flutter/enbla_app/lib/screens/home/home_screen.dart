import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enbla Restaurant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Enbla',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 25),

            Text(
              'Reserve tables easily and manage restaurants.',
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                // restaurant list will be added later
              },
              child: Text('Browse Restaurants'),
            ),

            SizedBox(height: 15),

            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/select-role');
              },
              child: Text('Login'),
            ),

            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/select-role');
              },
              child: Text('Create Account'),
            ),
          ],
        ),
      ),
    );
  }
}
