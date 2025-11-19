import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rice_chat/core/chat_room_id_utils.dart';
import 'package:rice_chat/data/model/chat_entity.dart';
import 'package:rice_chat/data/model/chat_room_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_repository.g.dart';

class ChatRepository {
  ChatRepository({required this.db});

  final FirebaseFirestore db;

  /// roomId의 messages 컬렉션 레퍼런스
  CollectionReference<Map<String, dynamic>> _messages(String roomId) {
    return db.collection('chats').doc(roomId).collection('messages');
  }

  /// 현재 채팅방의 메세지 가져오기
  Future<List<ChatEntity>?> getChatMessages(String roomId) async {
    try {
      final query = await _messages(roomId).orderBy('created_at', descending: false).get();
      return query.docs.map((doc) => ChatEntity.fromJson({'id': doc.id, ...doc.data()})).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  /// 현재 채팅방에 메세지 보내기
  Future<bool> sendMessage({
    required String roomId,
    required String sender,
    required String senderId,
    required String message,
    required String? imageUrl,
  }) async {
    try {
      final collection = _messages(roomId);
      final doc = collection.doc();
      await doc.set({
        "id": doc.id,
        "sender": sender,
        "sender_id": senderId,
        "message": message,
        "image_url": imageUrl,
        "created_at": FieldValue.serverTimestamp(),
      });

      // [채팅방 메타데이터 업데이트 (chats/{roomId})]
      final roomDoc = db.collection('chats').doc(roomId);
      final members = parseMembersFromRoomId(roomId);
      // unreadCount 필드 업데이트용 map 만들기
      final Map<String, dynamic> unreadUpdate = {};
      for (final memberId in members) {
        final key = 'unread_count_$memberId';
        if (memberId == senderId) {
          unreadUpdate[key] = 0; // 보낸 사람은 항상 0으로 리셋
        } else {
          unreadUpdate[key] = FieldValue.increment(1); // 상대는 +1
        }
      }
      await roomDoc.set({
        "members": FieldValue.arrayUnion(members), // 1:1 채팅 멤버
        "last_message": message, // 마지막 메시지
        "last_message_time": FieldValue.serverTimestamp(), // 마지막 메시지 시간
        "last_message_sender_id": senderId,
        "last_message_sender_name": sender,
        if (imageUrl != null) "image_url": imageUrl,
        ...unreadUpdate,
      }, SetOptions(merge: true));

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// 1:1 채팅방 내의 채팅 목록 스트림
  Stream<List<ChatEntity>> chatListStream(String roomId) {
    try {
      final snapshots = _messages(roomId).orderBy('created_at', descending: false).snapshots();
      return snapshots.map(
        (event) =>
            event.docs.map((doc) => ChatEntity.fromJson({'id': doc.id, ...doc.data()})).toList(),
      );
    } catch (e) {
      print(e);
      return Stream.empty();
    }
  }

  /// 내가 속한 1:1 채팅방 목록 스트림
  Stream<List<ChatRoomEntity>> chatRoomListStream(String myId) {
    try {
      final snapshots = db
          .collection('chats')
          .where('members', arrayContains: myId) // 내가 포함된 방만
          .orderBy('last_message_time', descending: true) // 최근 대화 순
          .snapshots();

      return snapshots.map(
        (query) => query.docs.map((doc) {
          final data = doc.data();

          return ChatRoomEntity(
            id: doc.id,
            members: List<String>.from(data['members'] ?? const []),
            lastMessage: data['last_message'] as String? ?? '',
            lastMessageTime: (data['last_message_time'] as Timestamp?)?.toDate(),
            unreadCount: (data['unread_count_$myId'] as int?) ?? 0,
          );
        }).toList(),
      );
    } catch (e) {
      print(e);
      return Stream.empty();
    }
  }

  /// 이 채팅방의 내 unreadCount를 0으로 리셋
  Future<void> resetUnreadCount({required String roomId, required String userId}) async {
    try {
      final roomDoc = db.collection('chats').doc(roomId);
      await roomDoc.set({'unread_count_$userId': 0}, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }
}

/// Repository Provider
@riverpod
ChatRepository chatRepository(Ref ref) {
  return ChatRepository(db: FirebaseFirestore.instance); // DI
}
