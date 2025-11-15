// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bottom_nav_bar_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BottomNavBarViewModel)
const bottomNavBarViewModelProvider = BottomNavBarViewModelProvider._();

final class BottomNavBarViewModelProvider
    extends $NotifierProvider<BottomNavBarViewModel, int> {
  const BottomNavBarViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bottomNavBarViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bottomNavBarViewModelHash();

  @$internal
  @override
  BottomNavBarViewModel create() => BottomNavBarViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$bottomNavBarViewModelHash() =>
    r'93c02da1feea620aa4c549c4524d17c49c75671e';

abstract class _$BottomNavBarViewModel extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
