import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageService {
  final SupabaseClient _client = Supabase.instance.client;

  /// Deletes all photos for a restaurant from the
  /// 'restaurant-photos/restaurants/{restaurantId}/' folder
  Future<void> deleteRestaurantPhoto(String restaurantId) async {
    final storage = _client.storage.from('restaurant-photos');
    final folderPath = 'restaurants/$restaurantId';

    final List<FileObject> files = await storage.list(path: folderPath);
    for (final file in files) {
      await storage.remove(['$folderPath/${file.name}']);
    }
  }

  /// Uploads a photo to 'restaurant-photos/restaurants/{restaurantId}/' in Supabase Storage
  /// Supabase auto-creates folders on upload, so no need to pre-create them.
  Future<String?> uploadRestaurantPhoto(File file, String restaurantId) async {
    const bucketName = 'restaurant-photos';
    String fileName = file.path.split('/').last;
    // Sanitize file name: allow only alphanumeric, dash, underscore, dot
    fileName = fileName.replaceAll(RegExp(r'[^A-Za-z0-9._-]'), '_');
    final filePath =
        'restaurants/$restaurantId/${DateTime.now().millisecondsSinceEpoch}_$fileName';

    final storage = _client.storage.from(bucketName);
    print('Uploading to bucket: $bucketName, path: $filePath');

    try {
      // Upload the file (mobile/desktop platforms that support dart:io File)
      await storage.upload(
        filePath,
        file,
        fileOptions: const FileOptions(upsert: false),
      );
      // Get public URL (bucket must be public or have appropriate policy)
      final url = storage.getPublicUrl(filePath);
      print('Supabase upload success, public URL: $url');
      return url;
    } catch (e) {
      print('Supabase upload error: $e');
      if (e.toString().contains('permission')) {
        print(
          'Possible cause: missing INSERT or SELECT storage policy for authenticated users on bucket $bucketName.',
        );
      } else if (e.toString().contains('bucket')) {
        print(
          'Possible cause: bucket $bucketName does not exist or is misspelled.',
        );
      }
      return null;
    }
  }

  // ensureRestaurantsFolder removed because Supabase auto-creates folders on upload.
}
