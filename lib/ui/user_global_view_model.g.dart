// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_global_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserGlobalViewModel)
const userGlobalViewModelProvider = UserGlobalViewModelFamily._();

final class UserGlobalViewModelProvider
    extends $AsyncNotifierProvider<UserGlobalViewModel, UserEntity> {
  const UserGlobalViewModelProvider._({
    required UserGlobalViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'userGlobalViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userGlobalViewModelHash();

  @override
  String toString() {
    return r'userGlobalViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  UserGlobalViewModel create() => UserGlobalViewModel();

  @override
  bool operator ==(Object other) {
    return other is UserGlobalViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userGlobalViewModelHash() =>
    r'2a8d364329017096f80feb2e673096eaeb0e6000';

final class UserGlobalViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          UserGlobalViewModel,
          AsyncValue<UserEntity>,
          UserEntity,
          FutureOr<UserEntity>,
          String
        > {
  const UserGlobalViewModelFamily._()
    : super(
        retry: null,
        name: r'userGlobalViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UserGlobalViewModelProvider call(String userId) =>
      UserGlobalViewModelProvider._(argument: userId, from: this);

  @override
  String toString() => r'userGlobalViewModelProvider';
}

abstract class _$UserGlobalViewModel extends $AsyncNotifier<UserEntity> {
  late final _$args = ref.$arg as String;
  String get userId => _$args;

  FutureOr<UserEntity> build(String userId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<UserEntity>, UserEntity>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UserEntity>, UserEntity>,
              AsyncValue<UserEntity>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
