// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_write_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PostWriteViewModel)
const postWriteViewModelProvider = PostWriteViewModelProvider._();

final class PostWriteViewModelProvider
    extends $NotifierProvider<PostWriteViewModel, PostWriteState> {
  const PostWriteViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postWriteViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postWriteViewModelHash();

  @$internal
  @override
  PostWriteViewModel create() => PostWriteViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PostWriteState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PostWriteState>(value),
    );
  }
}

String _$postWriteViewModelHash() =>
    r'2c9fc94b6315256c0750a1febff9f6fce68ab474';

abstract class _$PostWriteViewModel extends $Notifier<PostWriteState> {
  PostWriteState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PostWriteState, PostWriteState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PostWriteState, PostWriteState>,
              PostWriteState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
