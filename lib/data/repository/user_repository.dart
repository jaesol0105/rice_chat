import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rice_chat/data/model/user_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class UserRepository {
  UserRepository({required this.db});

  final FirebaseFirestore db;

  /// 유저 정보 추가 및 업데이트
  Future<void> updateUser(UserEntity user) async {
    await db
        .collection('users')
        .doc(user.id)
        .set(
          user.toJson(),
          SetOptions(merge: true), // 기존 데이터 유지
        );
  }
}

/// Repository Provider
@riverpod
UserRepository userRepository(Ref ref) {
  return UserRepository(db: FirebaseFirestore.instance); // DI
}
