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

  String? _currentUid; // 현재 구독 중인 uid 기억

  @override
  List<ChatRoomEntity> build() {
    final uid = ref.watch(currentUserIdProvider);

    // 로그인 검증
    if (uid == null) {
      _sub?.cancel();
      return [];
    }

    // uid가 바뀐 경우에만 새로 listen (무한 listen 연결 방지)
    if (uid != _currentUid) {
      _currentUid = uid;
      _listen(uid);
    }

    ref.onDispose(() {
      _sub?.cancel();
    });

    return state;
  }

  void _listen(String uid) {
    _sub?.cancel(); // 이전 구독이 있으면 정리

    // 채팅방 리스트 불러오기
    final stream = repo.chatRoomListStream(uid);

    _sub = stream.listen((rooms) {
      state = rooms; // Firestore에서 스냅샷 올 때마다 state 갱신
    });
  }
}
