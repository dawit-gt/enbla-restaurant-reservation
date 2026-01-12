// lib/screens/manager/manager_add_restaurant_screen.dart
import 'package:flutter/material.dart';
import '../../widgets/text_input_field.dart';
import '../../widgets/primary_button.dart';

class ManagerAddRestaurantScreen extends StatefulWidget {
  static const routeName = '/manager/restaurant/add';

  const ManagerAddRestaurantScreen({super.key});

  @override
  State<ManagerAddRestaurantScreen> createState() =>
      _ManagerAddRestaurantScreenState();
}

class _ManagerAddRestaurantScreenState
    extends State<ManagerAddRestaurantScreen> {
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Restaurant')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextInputField(controller: _nameController, hintText: 'Name'),
              const SizedBox(height: 12),
              TextInputField(
                controller: _locationController,
                hintText: 'Location',
              ),
              const SizedBox(height: 12),
              TextInputField(
                controller: _descriptionController,
                hintText: 'Description',
                maxLines: 4,
              ),
              const SizedBox(height: 12),
              TextInputField(
                controller: _imageUrlController,
                hintText: 'Image URL',
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: 'Add Restaurant',
                onPressed: () {
                  // TODO: add to Firestore
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
