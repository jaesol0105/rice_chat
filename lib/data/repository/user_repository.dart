import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rice_chat/data/model/user_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository.g.dart';

class UserRepository {
  UserRepository({required this.db});

  final FirebaseFirestore db;

  /// 유저 정보 추가 및 업데이트
  Future<void> updateUser(UserEntity user) async {
    try {
      await db
          .collection('users')
          .doc(user.id)
          .set(
            user.toJson(),
            SetOptions(merge: true), // 기존 데이터 유지
          );
    } catch (e) {
      print("ERROR_updateUser: $e");
    }
  }

  Future<UserEntity> getUser(String userId) async {
    try {
      final doc = await db.collection('users').doc(userId).get();
      if (!doc.exists) {
        throw Exception('User not found (id: $userId)');
      }

      return UserEntity.fromJson({...doc.data()!, 'id': doc.id});
    } catch (e) {
      print("ERROR_getUser: $e");
    }
  }
}

/// Repository Provider
@riverpod
UserRepository userRepository(Ref ref) {
  return UserRepository(db: FirebaseFirestore.instance); // DI
}
