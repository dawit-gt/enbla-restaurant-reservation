// lib/screens/manager/manager_edit_restaurant_screen.dart
import 'package:flutter/material.dart';
import '../../models/restaurant.dart';
import '../../widgets/text_input_field.dart';
import '../../widgets/primary_button.dart';

class ManagerEditRestaurantScreen extends StatefulWidget {
  static const routeName = '/manager/restaurant/edit';

  const ManagerEditRestaurantScreen({super.key});

  @override
  State<ManagerEditRestaurantScreen> createState() =>
      _ManagerEditRestaurantScreenState();
}

class _ManagerEditRestaurantScreenState
    extends State<ManagerEditRestaurantScreen> {
  late TextEditingController _nameController;
  late TextEditingController _locationController;
  late TextEditingController _descriptionController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final restaurant =
        ModalRoute.of(context)!.settings.arguments as Restaurant;
    _nameController = TextEditingController(text: restaurant.name);
    _locationController = TextEditingController(text: restaurant.location);
    _descriptionController =
        TextEditingController(text: restaurant.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Restaurant'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextInputField(
                controller: _nameController,
                hintText: 'Name',
              ),
              const SizedBox(height: 12),
              TextInputField(
                controller: _locationController,
                hintText: 'Location',
              ),
              const SizedBox(height: 12),
              TextInputField(
                controller: _descriptionController,
                hintText: 'Description',
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: 'Save Changes',
                onPressed: () {
                  // TODO: update Firestore
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
