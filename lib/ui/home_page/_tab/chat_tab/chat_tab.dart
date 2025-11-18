import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rice_chat/core/auth/current_user_id_provider.dart';
import 'package:rice_chat/core/chat_room_id_utils.dart';
import 'package:rice_chat/ui/chat_page/chat_page.dart';

class ChatTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque, // 빈 공간까지 터치 가능하게
      onTap: () {
        // 테스트
        final uid = ref.watch(currentUserIdProvider);
        if (uid == null) {
          // 로그인 안 됐거나 아직 uid를 못 가져온 상태
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('로그인 이후 이용 가능합니다.')));
          return;
        }
        final roomId = buildRoomId(uid, uid);

        Navigator.push(context, MaterialPageRoute(builder: (_) => ChatPage(roomId)));
      },
      child: Center(child: Container(width: 100, height: 100, child: Text('채팅'))),
    );
  }
}
