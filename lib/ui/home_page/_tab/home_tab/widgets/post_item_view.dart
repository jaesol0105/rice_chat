import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rice_chat/core/auth/current_user_id_provider.dart';
import 'package:rice_chat/core/chat_room_id_utils.dart';
import 'package:rice_chat/core/date_time_utils.dart';
import 'package:rice_chat/data/model/post_entity.dart';
import 'package:rice_chat/ui/chat_page/chat_page.dart';
import 'package:rice_chat/ui/detail_page/detail_page.dart';
import 'package:rice_chat/ui/home_page/_tab/home_tab/user_by_id_provider.dart';

class PostItemView extends ConsumerWidget {
  PostItemView({super.key, required this.posts});

  final PostEntity posts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userByIdProvider(posts.writer));

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return PostDetailPage(postId: posts.id);
            },
          ),
        );
      },
      child: Container(
        height: 110,
        width: double.infinity,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: const Color(0xFFD2D5DA)),
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 14.0, left: 12.0),
              child: Container(
                width: 60,
                height: 60,
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: user.when(
                    data: (user) => user.profileImgUrl != null
                        ? NetworkImage(user.profileImgUrl!)
                        : null,
                    loading: () => null,
                    error: (e, st) => null,
                  ),
                  child: user.when(
                    data: (user) => user.profileImgUrl == null
                        ? Icon(Icons.person, size: 40, color: Colors.white)
                        : null,
                    loading: () => CircularProgressIndicator(),
                    error: (e, st) => Icon(Icons.person_off),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 12.0,
                  right: 12.0,
                  bottom: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      posts.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),

                    Expanded(
                      child: Text(
                        posts.content,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      DateTimeUtils.formatString(posts.createdAt!),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 40,
              height: 110,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Builder(
                  builder: (_) {
                    final myUid = ref.watch(currentUserIdProvider);
                    final targetUid = posts.writer;
                    // 내 글이면 아이콘 안 보이게
                    if (myUid == targetUid) {
                      return const SizedBox.shrink();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6, right: 12),
                      child: GestureDetector(
                        onTap: () {
                          if (myUid == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('로그인 오류')),
                            );
                            return;
                          }
                          final roomId = buildRoomId(myUid, targetUid);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => ChatPage(roomId)),
                          );
                        },
                        child: Container(
                          width: 45,
                          height: 45,
                          color: Colors.transparent,
                          child: const Icon(
                            Icons.send,
                            size: 22,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
