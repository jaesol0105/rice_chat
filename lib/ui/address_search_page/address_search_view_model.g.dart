// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_search_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AddressSearchViewModel)
const addressSearchViewModelProvider = AddressSearchViewModelProvider._();

final class AddressSearchViewModelProvider
    extends $AsyncNotifierProvider<AddressSearchViewModel, List<String>> {
  const AddressSearchViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addressSearchViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addressSearchViewModelHash();

  @$internal
  @override
  AddressSearchViewModel create() => AddressSearchViewModel();
}

String _$addressSearchViewModelHash() =>
    r'e2b9b0504454ea4c74c018bd7500e720c24d0eb3';

abstract class _$AddressSearchViewModel extends $AsyncNotifier<List<String>> {
  FutureOr<List<String>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<String>>, List<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<String>>, List<String>>,
              AsyncValue<List<String>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
