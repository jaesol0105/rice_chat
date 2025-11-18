// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_by_id_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userById)
const userByIdProvider = UserByIdFamily._();

final class UserByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<UserEntity>,
          UserEntity,
          FutureOr<UserEntity>
        >
    with $FutureModifier<UserEntity>, $FutureProvider<UserEntity> {
  const UserByIdProvider._({
    required UserByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'userByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userByIdHash();

  @override
  String toString() {
    return r'userByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<UserEntity> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<UserEntity> create(Ref ref) {
    final argument = this.argument as String;
    return userById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UserByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userByIdHash() => r'825daf34ea0c6f568aea4f706eab422917329d21';

final class UserByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<UserEntity>, String> {
  const UserByIdFamily._()
    : super(
        retry: null,
        name: r'userByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UserByIdProvider call(String userId) =>
      UserByIdProvider._(argument: userId, from: this);

  @override
  String toString() => r'userByIdProvider';
}
