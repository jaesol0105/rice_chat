import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rice_chat/ui/home_page/_tab/home_tab/home_tab_view_model.dart';
import 'package:rice_chat/ui/home_page/_tab/home_tab/widgets/post_item_view.dart';

class PostListView extends HookConsumerWidget {
  const PostListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeTabViewModelProvider);
    final vm = ref.read(homeTabViewModelProvider.notifier);

    return Expanded(
      child: state.when(
        data: (homeTabState) {
          final posts = homeTabState.posts;
          // 스크롤 새로고침
          return RefreshIndicator(
            onRefresh: vm.getPosts,
            child: posts.isEmpty
                ? ListView(
                    padding: const EdgeInsets.only(top: 100),
                    children: const [
                      // 포스트가 존재하지 않을 경우
                      Center(child: Text("현재 지역에서 작성된 게시글이 없습니다.", textAlign: TextAlign.center)),
                    ],
                  )
                : ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    itemCount: posts.length,
                    itemBuilder: (_, index) {
                      return PostItemView(posts: posts[index]);
                    },
                    separatorBuilder: (_, __) => SizedBox(height: 20),
                  ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text("error: $e")),
      ),
    );
  }
}
