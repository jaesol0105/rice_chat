import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rice_chat/data/model/user_entity.dart';
import 'package:rice_chat/data/repository/user_repository.dart';

part 'user_by_id_provider.g.dart';

@riverpod
Future<UserEntity> userById(Ref ref, String userId) async {
  final repo = ref.watch(userRepositoryProvider);
  return repo.getUser(userId);
}
