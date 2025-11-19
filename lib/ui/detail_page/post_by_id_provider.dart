import 'package:rice_chat/data/model/post_entity.dart';
import 'package:rice_chat/data/repository/post_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_by_id_provider.g.dart';

@riverpod
Future<PostEntity?> postById(Ref ref, ({String address, String postId}) arg) async {
  final repo = ref.watch(postRepositoryProvider);
  return repo.getPostById(arg.address, arg.postId);
}
