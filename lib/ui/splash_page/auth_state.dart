import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rice_chat/data/model/user_check_status.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isLoading,
    @Default(null) String? error,
    User? user, // 구글 로그인으로 얻은 Firebase User
    UserCheckStatus? exist, // 기존 회원 여부
  }) = _AuthState;
}
