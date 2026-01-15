import 'package:flutter/material.dart';

class ManagerAddRestaurantScreen extends StatefulWidget {
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
  final _managerController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _managerController.dispose();
    super.dispose();
  }

  void _onBack() {
    Navigator.pop(context);
  }

  void _onUploadPhoto() {
    // TODO: open image picker
  }

  void _onAdd() {
    // TODO: validate & send to backend (e.g. Firebase)
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    const headerColor = Color(0xFF6F3738);
    const fieldColor = Color(0xFFE3D3C3);
    const bulletColor = Color(0xFF7F3335);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          Container(
            color: headerColor,
            padding:
                const EdgeInsets.only(top: 40, left: 12, right: 20, bottom: 12),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: _onBack,
                ),
                const SizedBox(width: 4),
                const Expanded(
                  child: Text(
                    'Add\nRestaurant',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                ),
                Row(
                  children: const [
                    Text(
                      'Hello, Manger Get',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: Text(
                        'G',
                        style: TextStyle(
                          color: headerColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Body
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Upload photo
                  _BulletRow(
                    bulletColor: bulletColor,
                    label: 'Upload photo:',
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.upload,
                        color: Colors.black,
                      ),
                      onPressed: _onUploadPhoto,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Name
                  _LabeledField(
                    bulletColor: bulletColor,
                    label: 'Name:',
                    child: _RoundedTextField(
                      controller: _nameController,
                      color: fieldColor,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Location
                  _LabeledField(
                    bulletColor: bulletColor,
                    label: 'Location:',
                    child: _RoundedTextField(
                      controller: _locationController,
                      color: fieldColor,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Description
                  _LabeledField(
                    bulletColor: bulletColor,
                    label: 'Description:',
                    child: _RoundedTextField(
                      controller: _descriptionController,
                      color: fieldColor,
                      maxLines: 4,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Manager
                  _LabeledField(
                    bulletColor: bulletColor,
                    label: 'Manger:',
                    child: _RoundedTextField(
                      controller: _managerController,
                      color: fieldColor,
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Add button
                  Center(
                    child: SizedBox(
                      width: 140,
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
                        onPressed: _onAdd,
                        child: const Text(
                          'Add',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
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
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
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
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
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
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
