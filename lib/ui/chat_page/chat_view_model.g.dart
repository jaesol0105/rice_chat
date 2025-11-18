// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChatViewModel)
const chatViewModelProvider = ChatViewModelFamily._();

final class ChatViewModelProvider
    extends $NotifierProvider<ChatViewModel, List<ChatEntity>> {
  const ChatViewModelProvider._({
    required ChatViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'chatViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$chatViewModelHash();

  @override
  String toString() {
    return r'chatViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ChatViewModel create() => ChatViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ChatEntity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ChatEntity>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ChatViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$chatViewModelHash() => r'91360e0d0e3ac094a0ef2ee4e6418cbec40e4d69';

final class ChatViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          ChatViewModel,
          List<ChatEntity>,
          List<ChatEntity>,
          List<ChatEntity>,
          String
        > {
  const ChatViewModelFamily._()
    : super(
        retry: null,
        name: r'chatViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ChatViewModelProvider call(String roomId) =>
      ChatViewModelProvider._(argument: roomId, from: this);

  @override
  String toString() => r'chatViewModelProvider';
}

abstract class _$ChatViewModel extends $Notifier<List<ChatEntity>> {
  late final _$args = ref.$arg as String;
  String get roomId => _$args;

  List<ChatEntity> build(String roomId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<List<ChatEntity>, List<ChatEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<ChatEntity>, List<ChatEntity>>,
              List<ChatEntity>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
