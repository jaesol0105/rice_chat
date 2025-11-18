import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rice_chat/core/auth/current_user_id_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rice_chat/data/model/user_entity.dart';
import 'package:rice_chat/data/repository/user_repository.dart';

part 'user_global_view_model.g.dart';

@riverpod
class UserGlobalViewModel extends _$UserGlobalViewModel {
  UserRepository get repo => ref.read(userRepositoryProvider);

  @override
  Future<UserEntity?> build() async {
    final uid = ref.watch(currentUserIdProvider);
    if (uid == null) {
      throw Exception('로그인 오류');
    }
    return await repo.getUser(uid);
  }
}
