String buildRoomId(String uid1, String uid2) {
  final ids = [uid1, uid2]..sort(); // 항상 같은 순서 보장
  return '${ids[0]}_${ids[1]}';
}
