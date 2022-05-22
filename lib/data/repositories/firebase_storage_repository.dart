import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirebaseStorageRepository {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(String filePath, String uid) async {
    File file = File(filePath);
    try {
      await storage.ref('$uid/profile/').child('profile_image').putFile(file);
    } catch (_) {
      return Future.error("Error occurred");
    }
  }

  Future<String?> downloadUrl(String uid) async {
    try {
      final result = await storage.ref("$uid/profile/").list();
      if (result.items.isNotEmpty) {
        String downloadUrl =
            await storage.ref('$uid/profile/profile_image').getDownloadURL();
        return downloadUrl;
      } else {
        return null;
      }
    } catch (_) {
      return Future.error("Error occurred");
    }
  }
}
