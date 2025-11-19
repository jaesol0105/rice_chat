// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_by_id_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(postById)
const postByIdProvider = PostByIdFamily._();

final class PostByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<PostEntity?>,
          PostEntity?,
          FutureOr<PostEntity?>
        >
    with $FutureModifier<PostEntity?>, $FutureProvider<PostEntity?> {
  const PostByIdProvider._({
    required PostByIdFamily super.from,
    required ({String address, String postId}) super.argument,
  }) : super(
         retry: null,
         name: r'postByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$postByIdHash();

  @override
  String toString() {
    return r'postByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PostEntity?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PostEntity?> create(Ref ref) {
    final argument = this.argument as ({String address, String postId});
    return postById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PostByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$postByIdHash() => r'08dd5ce1cc6f9628d9e9f02a1da1be20e6b49696';

final class PostByIdFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<PostEntity?>,
          ({String address, String postId})
        > {
  const PostByIdFamily._()
    : super(
        retry: null,
        name: r'postByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PostByIdProvider call(({String address, String postId}) arg) =>
      PostByIdProvider._(argument: arg, from: this);

  @override
  String toString() => r'postByIdProvider';
}
