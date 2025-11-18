import 'package:firebase_auth/firebase_auth.dart';
import 'package:rice_chat/data/repository/auth_repository.dart';
import 'package:rice_chat/ui/splash_page/auth_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  @override
  AuthState build() {
    return AuthState();
  }

  /// 구글 계정 로그인
  Future<void> loginWithGoogle() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repo = ref.read(authRepositoryProvider);
      // 구글 계정 로그인
      final user = await repo.signInWithGoogle();
      // 화원가입 진행 단계 체크
      final exist = await repo.checkUserStatus(user.uid);
      // 유저 문서 생성
      await repo.createUser(uid: user.uid, provider: "google");
      state = state.copyWith(isLoading: false, user: user, exist: exist);
    } catch (e) {
      print("loginWithGoogle $e");
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
