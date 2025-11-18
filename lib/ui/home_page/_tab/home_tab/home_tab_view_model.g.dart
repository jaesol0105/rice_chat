// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_tab_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeTabViewModel)
const homeTabViewModelProvider = HomeTabViewModelProvider._();

final class HomeTabViewModelProvider
    extends $AsyncNotifierProvider<HomeTabViewModel, HomeTabState> {
  const HomeTabViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeTabViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeTabViewModelHash();

  @$internal
  @override
  HomeTabViewModel create() => HomeTabViewModel();
}

String _$homeTabViewModelHash() => r'db3efca4fd75e0ff08bb98ca60280f192c5afaba';

abstract class _$HomeTabViewModel extends $AsyncNotifier<HomeTabState> {
  FutureOr<HomeTabState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<HomeTabState>, HomeTabState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<HomeTabState>, HomeTabState>,
              AsyncValue<HomeTabState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
