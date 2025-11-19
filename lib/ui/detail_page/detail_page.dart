import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rice_chat/core/auth/current_user_id_provider.dart';
import 'package:rice_chat/core/chat_room_id_utils.dart';
import 'package:rice_chat/ui/chat_page/chat_page.dart';
import 'package:rice_chat/ui/detail_page/post_by_id_provider.dart';
import 'package:rice_chat/ui/home_page/_tab/home_tab/user_by_id_provider.dart';
import 'package:rice_chat/ui/user_global_view_model.dart';

class PostDetailPage extends ConsumerWidget {
  const PostDetailPage({super.key, required this.postId});

  final String postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // [유저 상태]
    final userAsync = ref.watch(userGlobalViewModelProvider);
    if (userAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (userAsync.hasError) {
      return const Scaffold(body: Center(child: Text('유저 정보를 불러오지 못했습니다.')));
    }
    final user = userAsync.value;
    if (user == null) {
      return const Scaffold(body: Center(child: Text('유저 정보가 없습니다.')));
    }

    final postAsync = ref.watch(postByIdProvider((address: user.address!, postId: postId)));
    return Scaffold(
      appBar: AppBar(),
      body: postAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('게시글을 불러오는 중 오류가 발생했어요.\n$e')),
        data: (post) {
          if (post == null) {
            return const Center(child: Text('게시글을 찾을 수 없습니다.'));
          }
          final userAsync = ref.watch(userByIdProvider(post.writer));
          return userAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(child: Text('작성자 정보를 불러오는 중 오류가 발생했어요.\n$e')),
            data: (user) {
              return Column(
                children: [
                  // 상단 이미지 슬라이더
                  SizedBox(
                    height: 350,
                    width: double.infinity,
                    child: (post.images == null || post.images!.isEmpty)
                        ? Container(color: const Color(0xFFD9D9D9))
                        : PostImageSlider(images: post.images!),
                  ),

                  // 내용 영역
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      children: [
                        // 작성자 + 프로필
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundImage: user.profileImgUrl != null
                                  ? NetworkImage(user.profileImgUrl!)
                                  : null,
                              backgroundColor: Colors.grey[300],
                              child: user.profileImgUrl == null
                                  ? const Icon(Icons.person, size: 32)
                                  : null,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // 내용
                        Text(post.content, style: const TextStyle(fontSize: 16, height: 1.5)),
                        const SizedBox(height: 16),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomChatButton(
        address: user.address!, // 유저 주소
        postId: postId,
      ),
    );
  }
}

/// 이미지 슬라이더 (PageView + 인디케이터)
class PostImageSlider extends HookWidget {
  const PostImageSlider({super.key, required this.images});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final currentIndex = useState(0);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // PageView
        PageView.builder(
          controller: pageController,
          itemCount: images.length,
          onPageChanged: (index) => currentIndex.value = index,
          itemBuilder: (context, index) {
            return Container(
              color: const Color(0xFFD9D9D9), // 기본 회색 배경
              width: double.infinity,
              child: Image.network(images[index], fit: BoxFit.cover, width: double.infinity),
            );
          },
        ),

        // 좌우 화살표
        if (images.length > 1) ...[
          Positioned(
            left: 12,
            bottom: 16,
            child: GestureDetector(
              onTap: () {
                if (currentIndex.value > 0) {
                  pageController.previousPage(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                  );
                }
              },
              child: Icon(Icons.chevron_left, size: 32, color: Colors.white.withOpacity(0.8)),
            ),
          ),
          Positioned(
            right: 12,
            bottom: 16,
            child: GestureDetector(
              onTap: () {
                if (currentIndex.value < images.length - 1) {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                  );
                }
              },
              child: Icon(Icons.chevron_right, size: 32, color: Colors.white.withOpacity(0.8)),
            ),
          ),
        ],

        // 인디케이터
        if (images.length > 1)
          Positioned(
            bottom: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                images.length,
                (index) => Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex.value == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.4),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// 하단 버튼
class BottomChatButton extends ConsumerWidget {
  const BottomChatButton({super.key, required this.address, required this.postId});

  final String address;
  final String postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myUid = ref.watch(currentUserIdProvider);
    final postAsync = ref.watch(postByIdProvider((address: address, postId: postId)));

    return postAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (e, st) => const SizedBox.shrink(),
      data: (post) {
        if (post == null) return const SizedBox.shrink();

        final isMine = myUid != null && myUid == post.writer;

        return SafeArea(
          minimum: const EdgeInsets.all(16),
          child: SizedBox(
            height: 56,
            width: double.infinity,
            child: isMine
                ? SizedBox.shrink()
                : ElevatedButton(
                    onPressed: () {
                      if (myUid == null) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(const SnackBar(content: Text('로그인 후 이용해주세요.')));
                        return;
                      }

                      if (isMine) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(const SnackBar(content: Text('미구현 기능입니다.')));
                        return;
                      }

                      final roomId = buildRoomId(myUid, post.writer);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => ChatPage(roomId)));
                    },
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            '채팅으로 이동',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.send_rounded, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
