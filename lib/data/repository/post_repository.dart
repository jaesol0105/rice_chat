import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rice_chat/data/model/post_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_repository.g.dart';

class PostRepository {
  PostRepository({required this.db});

  final FirebaseFirestore db;

  // 포스트 생성
  Future<void> createPost({required PostEntity post, required String address}) async {
    try {
      await db.collection("posts").doc(address).collection("posts").doc(post.id).set({
        ...post.toJson(),
        'created_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("ERROR_createPost: $e");
      rethrow;
    }
  }

  // 지역에 해당하는 포스트 불러오기
  Future<List<PostEntity>> getPosts(String address) async {
    try {
      // posts > address > posts
      final snapshot = await db.collection("posts").doc(address).collection("posts").get();
      final iterable = snapshot.docs.map((e) => PostEntity.fromJson(e.data()));

      return iterable.toList();
    } catch (e) {
      print("ERROR_getPosts: $e");
      return [];
    }
  }
}

/// Repository Provider
@riverpod
PostRepository postRepository(Ref ref) {
  return PostRepository(db: FirebaseFirestore.instance); // DI
}
