import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rice_chat/core/date_time_utils.dart';
import 'package:rice_chat/data/model/post_entity.dart';
import 'package:rice_chat/ui/user_global_view_model.dart';

class PostItemView extends ConsumerWidget {
  PostItemView({super.key, required this.posts});

  final PostEntity posts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userGlobalViewModelProvider(posts.writer));

    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) {
        //       return ProductDetailPage(productSummary.id);
        //     },
        //   ),
        // );
      },
      child: Container(
        height: 120,
        width: double.infinity,
        color: Colors.transparent,
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                // 글 쓴 사람 프로필 사진
                child: user.when(
                  data: (user) => user.profileImgUrl == null
                      ? Container(color: Colors.grey[300])
                      : Image.network(user.profileImgUrl!, fit: BoxFit.cover),
                  loading: () => Container(color: Colors.grey[300]),
                  error: (e, st) =>
                      Container(color: Colors.grey[300], child: Icon(Icons.person_off)),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(posts.title),
                  SizedBox(height: 2),
                  Text(posts.content, style: TextStyle(fontSize: 13)),
                  SizedBox(height: 4),
                  Text(
                    DateTimeUtils.formatString(posts.createdAt!),
                    style: TextStyle(fontSize: 11, color: Colors.black38),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}
