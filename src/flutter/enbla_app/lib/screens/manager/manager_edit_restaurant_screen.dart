import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../services/supabase_storage_service.dart';

class ManagerEditRestaurantScreen extends StatefulWidget {
  const ManagerEditRestaurantScreen({super.key});

  @override
  State<ManagerEditRestaurantScreen> createState() =>
      _ManagerEditRestaurantScreenState();
}

class _ManagerEditRestaurantScreenState
    extends State<ManagerEditRestaurantScreen> {
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _restaurantId;
  String? _photoUrl;
  File? _selectedPhoto;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    Future.microtask(_fetchRestaurant);
  }

  Future<void> _fetchRestaurant() async {
    // Get restaurantId from arguments
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) {
      _restaurantId = args;
      final doc = await FirebaseFirestore.instance
          .collection('restaurants')
          .doc(_restaurantId)
          .get();
      final data = doc.data();
      if (data != null) {
        _nameController.text = data['name'] ?? '';
        _locationController.text = data['location'] ?? '';
        _descriptionController.text = data['description'] ?? '';
        _photoUrl = data['photoUrl'] as String?;
      }
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onBack() {
    Navigator.pop(context);
  }

  void _onUploadPhoto() {
    final picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery, imageQuality: 80).then((
      picked,
    ) {
      if (picked != null) {
        setState(() {
          _selectedPhoto = File(picked.path);
        });
      }
    });
  }

  void _onUpdate() async {
    if (_restaurantId == null) {
      print('No restaurantId provided.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: No restaurant ID found.')),
      );
      return;
    }
    setState(() {
      _loading = true;
    });
    final name = _nameController.text.trim();
    final location = _locationController.text.trim();
    final description = _descriptionController.text.trim();
    String? photoUrl = _photoUrl;
    try {
      if (_selectedPhoto != null) {
        print('Uploading image to Supabase...');
        photoUrl = await SupabaseStorageService().uploadRestaurantPhoto(
          _selectedPhoto!,
          _restaurantId!,
        );
        print('Supabase upload result: $photoUrl');
        if (photoUrl == null) {
          setState(() {
            _loading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Photo upload failed! Check your Supabase Storage policy, bucket name, and permissions.',
              ),
            ),
          );
          return;
        }
      }
      print('Updating Firestore restaurant...');
      await FirebaseFirestore.instance
          .collection('restaurants')
          .doc(_restaurantId)
          .update({
            'name': name,
            'location': location,
            'description': description,
            if (photoUrl != null) 'photoUrl': photoUrl,
          });
      print('Firestore update complete.');
      if (mounted) {
        setState(() {
          _loading = false;
        });
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Restaurant updated successfully!')),
        );
      }
    } catch (e) {
      print('Update error: $e');
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Update failed: $e')));
    }
    print('Update button logic finished.');
  }

  @override
  Widget build(BuildContext context) {
    const headerColor = Color(0xFF6F3738);
    const fieldColor = Color(0xFFE3D3C3);
    const bulletColor = Color(0xFF7F3335);

    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          Container(
            color: headerColor,
            padding: const EdgeInsets.only(
              top: 40,
              left: 12,
              right: 20,
              bottom: 12,
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: _onBack,
                ),
                const SizedBox(width: 4),
                const Expanded(
                  child: Text(
                    'Edit\nRestaurant',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Text(
                  'Hello, Manager',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          // Body
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Abebe Restaurant',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Upload photo row
                  _BulletRow(
                    bulletColor: bulletColor,
                    label: 'Upload photo:',
                    trailing: IconButton(
                      icon: const Icon(Icons.upload, color: Colors.black),
                      onPressed: _onUploadPhoto,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Name field
                  _LabeledField(
                    bulletColor: bulletColor,
                    label: 'Name:',
                    child: _RoundedTextField(
                      controller: _nameController,
                      color: fieldColor,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Location field
                  _LabeledField(
                    bulletColor: bulletColor,
                    label: 'Location:',
                    child: _RoundedTextField(
                      controller: _locationController,
                      color: fieldColor,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Description (bigger field)
                  _LabeledField(
                    bulletColor: bulletColor,
                    label: 'Description:',
                    child: _RoundedTextField(
                      controller: _descriptionController,
                      color: fieldColor,
                      maxLines: 4,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Update button
                  Center(
                    child: SizedBox(
                      width: 160,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: headerColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 6,
                          shadowColor: Colors.black45,
                        ),
                        onPressed: _onUpdate,
                        child: const Text(
                          'Update',
                          style: TextStyle(fontWeight: FontWeight.w600),
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
    );
  }
}

class _BulletRow extends StatelessWidget {
  final Color bulletColor;
  final String label;
  final Widget? trailing;

  const _BulletRow({
    required this.bulletColor,
    required this.label,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _BulletDot(color: bulletColor),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
        const SizedBox(width: 8),
        if (trailing != null) trailing!,
      ],
    );
  }
}

class _LabeledField extends StatelessWidget {
  final Color bulletColor;
  final String label;
  final Widget child;

  const _LabeledField({
    required this.bulletColor,
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BulletDot(color: bulletColor),
        const SizedBox(width: 8),
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: child),
      ],
    );
  }
}

class _RoundedTextField extends StatelessWidget {
  final TextEditingController controller;
  final Color color;
  final int maxLines;

  const _RoundedTextField({
    required this.controller,
    required this.color,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        filled: true,
        fillColor: color,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _BulletDot extends StatelessWidget {
  final Color color;

  const _BulletDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.only(top: 6),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
