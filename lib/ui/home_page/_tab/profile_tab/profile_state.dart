
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rice_chat/data/model/user_entity.dart';

part 'profile_state.freezed.dart';

@freezed
abstract class ProfileState with _$ProfileState{
  const factory ProfileState({
    UserEntity? user,
    String? profileImgUrl,
  }) = _ProfileState;
}