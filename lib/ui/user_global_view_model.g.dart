// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_global_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserGlobalViewModel)
const userGlobalViewModelProvider = UserGlobalViewModelProvider._();

final class UserGlobalViewModelProvider
    extends $AsyncNotifierProvider<UserGlobalViewModel, UserEntity?> {
  const UserGlobalViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userGlobalViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userGlobalViewModelHash();

  @$internal
  @override
  UserGlobalViewModel create() => UserGlobalViewModel();
}

String _$userGlobalViewModelHash() =>
    r'815f32eac3db49804f10909f6a88458a518f4517';

abstract class _$UserGlobalViewModel extends $AsyncNotifier<UserEntity?> {
  FutureOr<UserEntity?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<UserEntity?>, UserEntity?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UserEntity?>, UserEntity?>,
              AsyncValue<UserEntity?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
