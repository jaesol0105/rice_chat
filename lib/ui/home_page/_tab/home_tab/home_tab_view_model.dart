import 'package:rice_chat/core/auth/current_user_id_provider.dart';
import 'package:rice_chat/data/repository/post_repository.dart';
import 'package:rice_chat/ui/home_page/_tab/home_tab/home_tab_state.dart';
import 'package:rice_chat/ui/user_global_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_tab_view_model.g.dart';

@riverpod
class HomeTabViewModel extends _$HomeTabViewModel {
  PostRepository get repo => ref.read(postRepositoryProvider);

  @override
  Future<HomeTabState> build() async {
    // 나중에 authVM에서 상태 값으로 관리하도록 변경
    final uid = ref.watch(currentUserIdProvider);
    if (uid == null) {
      // 로그인 안 된 상태라면 빈 상태 리턴
      return const HomeTabState(address: '', posts: []);
    }
    final user = await ref.watch(userGlobalViewModelProvider.future);
    final address = user!.address;

    if (address == null || address.isEmpty) {
      return const HomeTabState(address: '', posts: []);
    }

    final posts = await repo.getPosts(address);
    return HomeTabState(address: address, posts: posts);
  }

  // 현재 지역 포스트 가져오기
  Future<void> getPosts() async {
    final currentState = state.value;
    if (currentState == null || currentState.address.isEmpty) {
      return;
    }

    state = AsyncLoading();

    // guard : try–catch + AsyncValue 변환까지 해줌
    state = await AsyncValue.guard(() async {
      final posts = await repo.getPosts(currentState.address);
      return currentState.copyWith(posts: posts);
    });
  }
}
