import 'package:rice_chat/data/repository/post_repository.dart';
import 'package:rice_chat/ui/home_page/_tab/home_tab/home_tab_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_tab_view_model.g.dart';

@riverpod
class HomeTabViewModel extends _$HomeTabViewModel {
  PostRepository get repo => ref.read(postRepositoryProvider);

  @override
  Future<HomeTabState> build() async {
    // final address = ref.read(userViewModel).address;
    final address = "경기도 군포시 금정동";
    final posts = await repo.getPosts(address);
    return HomeTabState(address: address, posts: posts);
  }

  // 지역 기반으로 포스트 목록 가지고오기
  Future<void> getPosts() async {
    state = AsyncLoading();

    // guard : try–catch + AsyncValue 변환까지 해줌
    state = await AsyncValue.guard(() async {
      final currentAddress = state.value!.address;
      final posts = await repo.getPosts(currentAddress);
      return HomeTabState(address: currentAddress, posts: posts);
    });
  }
}
