import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rice_chat/core/auth/current_user_id_provider.dart';
import 'package:rice_chat/data/model/chat_room_entity.dart';
import 'package:rice_chat/ui/chat_page/chat_page.dart';
import 'package:rice_chat/ui/home_page/_tab/chat_tab/chat_room_list_view_model.dart';
import 'package:rice_chat/ui/home_page/_tab/home_tab/user_by_id_provider.dart';
import 'package:rice_chat/ui/user_global_view_model.dart';

class ChatListPage extends HookConsumerWidget {
  const ChatListPage({super.key});

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

    // [채팅방 리스트 상태]
    final rooms = ref.watch(chatRoomListViewModelProvider);

    final scrollController = useScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('채팅', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: const Color(0xFFF8F4E8),
      ),
      body: rooms.isEmpty
          ? const Center(child: Text('진행 중인 채팅이 없습니다.\n대화를 시작해보세요!', textAlign: TextAlign.center))
          : ListView.separated(
              controller: scrollController,
              itemCount: rooms.length,
              separatorBuilder: (_, __) => const SizedBox(height: 1),
              itemBuilder: (context, index) {
                final room = rooms[index];
                return _ChatRoomTile(room: room);
              },
            ),
    );
  }
}

class _ChatRoomTile extends ConsumerWidget {
  const _ChatRoomTile({required this.room});

  final ChatRoomEntity room;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myId = ref.watch(currentUserIdProvider);

    // 혹시 null이면 그냥 빈 타일
    if (myId == null) {
      return const ListTile(title: Text('유저 정보 없음'));
    }

    // members 중에서 상대 id 찾기
    final otherId = room.members.firstWhere((id) => id != myId);

    // 유저 정보 가져오기
    final otherUserAsync = ref.watch(userByIdProvider(otherId));
    String name = '알 수 없음';
    String? profileImg;

    otherUserAsync.when(
      data: (user) {
        name = user.name;
        profileImg = user.profileImgUrl;
      },
      loading: () {},
      error: (e, st) {},
    );

    String timeText = '';
    if (room.lastMessageTime != null) {
      timeText = DateFormat('a hh:mm', 'ko_KR').format(room.lastMessageTime!);
    }

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.grey[300],
        backgroundImage: (profileImg != null && profileImg!.isNotEmpty)
            ? NetworkImage(profileImg!)
            : null,
        child: (profileImg == null || profileImg!.isEmpty)
            ? const Icon(Icons.person, color: Colors.white)
            : null,
      ),
      title: Text(
        name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text(
        room.lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Color(0xFF777777), fontSize: 14),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (timeText.isNotEmpty)
            Text(timeText, style: const TextStyle(fontSize: 12, color: Color(0xFF999999))),
          const SizedBox(height: 4),
          if (room.unreadCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                room.unreadCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => ChatPage(room.id)));
      },
    );
  }
}
