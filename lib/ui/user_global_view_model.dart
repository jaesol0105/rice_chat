import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rice_chat/data/model/user_entity.dart';
import 'package:rice_chat/data/repository/user_repository.dart';

part 'user_global_view_model.g.dart';

@riverpod
class UserGlobalViewModel extends _$UserGlobalViewModel {
  UserRepository get repo => ref.read(userRepositoryProvider);

  @override
  Future<UserEntity> build(String userId) async {
    final user = await repo.getUser(userId);
    return user;
  }
}
