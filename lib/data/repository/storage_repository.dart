import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'storage_repository.g.dart';

class StorageRepository {
  StorageRepository({required this.storage});

  final FirebaseStorage storage;

  @override
  Future<List<String>> uploadImages(List<XFile> files) async {
    final List<String> urls = [];

    try {
      for (final f in files) {
        final ext = p.extension(f.path);
        final name = "post_${DateTime.now().millisecondsSinceEpoch}_${urls.length}$ext";

        final ref = storage.ref().child("post_images/$name");

        await ref.putFile(File(f.path));
        final url = await ref.getDownloadURL();

        urls.add(url);
      }
    } catch (e) {
      print("ERROR_uploadImages: $e");
      rethrow;
    }

    return urls;
  }
}

/// Repository Provider
@riverpod
StorageRepository storageRepository(Ref ref) {
  return StorageRepository(storage: FirebaseStorage.instance); // DI
}
