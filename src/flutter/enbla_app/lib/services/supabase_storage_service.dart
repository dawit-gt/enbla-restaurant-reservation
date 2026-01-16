import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<String?> uploadRestaurantPhoto(File file, String restaurantId) async {
    final filePath =
        'restaurants/$restaurantId/${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
    final storage = _client.storage.from('restaurant-photos');
    try {
      await storage.upload(filePath, file);
      final url = storage.getPublicUrl(filePath);
      return url;
    } catch (e) {
      print('Upload error: $e');
      return null;
    }
  }
}
