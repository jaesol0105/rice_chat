class ChatRoomEntity {
  final String id; // roomId
  final List<String> members;
  final String lastMessage; // 마지막 메시지 내용
  final DateTime? lastMessageTime; // 마지막 메시지 시간
  final int unreadCount; // 안 읽은 메세지 개수

  ChatRoomEntity({
    required this.id,
    required this.members,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
  });
}
