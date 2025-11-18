import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rice_chat/data/model/chat_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_repository.g.dart';

class ChatRepository {
  ChatRepository({required this.db});

  final FirebaseFirestore db;

  /// roomId의 messages 컬렉션 레퍼런스
  CollectionReference<Map<String, dynamic>> _messages(String roomId) {
    return db.collection('chats').doc(roomId).collection('messages');
  }

  Future<List<ChatEntity>?> getChatMessages(String roomId) async {
    try {
      final query = await _messages(roomId).orderBy('created_at', descending: false).get();
      return query.docs.map((doc) => ChatEntity.fromJson({'id': doc.id, ...doc.data()})).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

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
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteMessage({required String roomId, required String messageId}) async {
    try {
      final doc = _messages(roomId).doc(messageId);
      await doc.delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

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
}

/// Repository Provider
@riverpod
ChatRepository chatRepository(Ref ref) {
  return ChatRepository(db: FirebaseFirestore.instance); // DI
}
