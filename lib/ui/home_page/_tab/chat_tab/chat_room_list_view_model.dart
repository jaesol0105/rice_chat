import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rice_chat/core/auth/current_user_id_provider.dart';
import 'package:rice_chat/data/model/chat_room_entity.dart';
import 'package:rice_chat/data/repository/chat_repository.dart';

part 'chat_room_list_view_model.g.dart';

@riverpod
class ChatRoomListViewModel extends _$ChatRoomListViewModel {
  StreamSubscription<List<ChatRoomEntity>>? _sub;
  ChatRepository get repo => ref.read(chatRepositoryProvider);

  @override
  List<ChatRoomEntity> build() {
    final uid = ref.watch(currentUserIdProvider);

    // 로그인 검증
    if (uid == null) {
      _sub?.cancel();
      return [];
    }

    _listen(uid);

    ref.onDispose(() {
      _sub?.cancel();
    });

    return [];
  }

  void _listen(String uid) {
    _sub?.cancel();

    // 채팅방 리스트 불러오기
    final stream = repo.chatRoomListStream(uid);

    _sub = stream.listen((rooms) {
      state = rooms;
    });
  }
}
