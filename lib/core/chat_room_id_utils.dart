String buildRoomId(String uid1, String uid2) {
  final ids = [uid1, uid2]..sort(); // 항상 같은 순서 보장
  return '${ids[0]}_${ids[1]}';
}

List<String> parseMembersFromRoomId(String roomId) {
  final parts = roomId.split('_');
  if (parts.length == 2) return parts;
  return parts; // 적당히 예외 처리
}
