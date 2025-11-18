import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';
part 'user_entity.g.dart';

@freezed
abstract class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String name,
    required int age,
    required bool sex,
    required String? address,
    @JsonKey(name: 'about_me') String? aboutMe,
    required String? profileImgUrl,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);
}
