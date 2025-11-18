import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rice_chat/data/model/chat_entity.dart';
import 'package:rice_chat/data/repository/chat_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_view_model.g.dart';

@riverpod
class ChatViewModel extends _$ChatViewModel {
  // 1. 뷰에서 ref.watch(chatViewModelProvider(roomId)) 호출
  // 2. build() 실행 = 스트림 구독 시작
  // 3. 위젯이 사라질 때 스트림 정리

  StreamSubscription<List<ChatEntity>>? _sub; // 스트림 구독
  ChatRepository get repo => ref.read(chatRepositoryProvider);

  @override
  List<ChatEntity> build(String roomId) {
    _listenStream(); // Firestore 스트림 구독 시작
    ref.onDispose(() {
      _sub?.cancel();
    });
    return [];
  }

  Future<void> getChatMessages() async {
    final result = await repo.getChatMessages(roomId);
    state = result ?? [];
  }

  Future<bool> sendMessage(ChatEntity newChat) async {
    final result = await repo.sendMessage(
      roomId: roomId,
      sender: newChat.sender,
      senderId: newChat.senderId,
      message: newChat.message,
      imageUrl: newChat.imageUrl,
    );
    return result;
  }

  void _listenStream() {
    _sub?.cancel(); // 혹시 이전 구독이 있으면 정리

    final stream = repo.chatListStream(roomId);
    _sub = stream.listen((chatList) {
      state = chatList;
    });
  }
}
