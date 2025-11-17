// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vworld_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(vworldRepository)
const vworldRepositoryProvider = VworldRepositoryProvider._();

final class VworldRepositoryProvider
    extends
        $FunctionalProvider<
          VworldRepository,
          VworldRepository,
          VworldRepository
        >
    with $Provider<VworldRepository> {
  const VworldRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vworldRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vworldRepositoryHash();

  @$internal
  @override
  $ProviderElement<VworldRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VworldRepository create(Ref ref) {
    return vworldRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VworldRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VworldRepository>(value),
    );
  }
}

String _$vworldRepositoryHash() => r'226f888f5936c860f32bb41a255ae3e28a122c85';
