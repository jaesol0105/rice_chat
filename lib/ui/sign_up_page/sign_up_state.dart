import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_state.freezed.dart';

@freezed
abstract class SignUpState with _$SignUpState {
  const factory SignUpState({
    @Default(false) bool isLoading,
    String? error,

    // 프로필 이미지 URL (Firebase Storage)
    String? profileImgUrl,
  }) = _SignUpState;
}
