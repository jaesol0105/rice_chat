import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_user_id_provider.g.dart';

@riverpod
String? currentUserId(Ref ref) {
  // 이 값은 로그인 후 설정하거나 FirebaseAuth에서 가져와도 됨
  return FirebaseAuth.instance.currentUser?.uid;
}
