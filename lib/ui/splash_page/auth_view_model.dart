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

  Future<User?> loginWithGoogle() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final repo = ref.read(authRepositoryProvider);

      final user = await repo.signInWithGoogle();

      await repo.createUpdateUser(
        uid: user.uid,
        email: user.email ?? "",
        provider: "google",
      );
      state = state.copyWith(isLoading: false);

      return user;
    } catch (e) {
      print(e);
      state = state.copyWith(isLoading: false, error: e.toString());
      return null;
    }
  }
}
