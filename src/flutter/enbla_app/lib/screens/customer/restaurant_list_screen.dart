import 'package:flutter/material.dart';

class RestaurantListScreen extends StatelessWidget {
  RestaurantListScreen({Key? key}) : super(key: key);

  final List<String> restaurants = [
    'Blue Moon Restaurant',
    'Habesha Kitchen',
    'Italian Corner',
    'Sunset Grill',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants'),
      ),
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(restaurants[index]),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // restaurant details later
            },
          );
        },
      ),
    );
  }
}
