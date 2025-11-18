class ChatRoomEntity {
  final String id; // roomId
  final String title; // 방 이름
  final String lastMessage; // 마지막 메시지 내용
  final DateTime? lastMessageTime; // 마지막 메시지 시간
  final String? imageUrl; // 상대 프로필 사진
  final int unreadCount; // 안 읽은 메세지 개수

  ChatRoomEntity({
    required this.id,
    required this.title,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.imageUrl,
    required this.unreadCount,
  });
}
