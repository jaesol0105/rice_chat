import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rice_chat/data/model/post_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_repository.g.dart';

class PostRepository {
  PostRepository({required this.db});

  final FirebaseFirestore db;

  // 포스트 생성
  Future<void> createPost({required PostEntity post, required String address}) async {
    await db.collection("posts").doc(address).collection("posts").doc(post.id).set({
      ...post.toJson(),
      'created_at': FieldValue.serverTimestamp(),
    });
  }
}

/// Repository Provider
@riverpod
PostRepository postRepository(Ref ref) {
  return PostRepository(db: FirebaseFirestore.instance); // DI
}
