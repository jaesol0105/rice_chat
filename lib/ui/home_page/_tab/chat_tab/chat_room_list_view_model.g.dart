// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_list_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChatRoomListViewModel)
const chatRoomListViewModelProvider = ChatRoomListViewModelProvider._();

final class ChatRoomListViewModelProvider
    extends $NotifierProvider<ChatRoomListViewModel, List<ChatRoomEntity>> {
  const ChatRoomListViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatRoomListViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatRoomListViewModelHash();

  @$internal
  @override
  ChatRoomListViewModel create() => ChatRoomListViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ChatRoomEntity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ChatRoomEntity>>(value),
    );
  }
}

String _$chatRoomListViewModelHash() =>
    r'f358c71ad4f2ff6da4e0a190512111c9e5bfebb7';

abstract class _$ChatRoomListViewModel extends $Notifier<List<ChatRoomEntity>> {
  List<ChatRoomEntity> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<ChatRoomEntity>, List<ChatRoomEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<ChatRoomEntity>, List<ChatRoomEntity>>,
              List<ChatRoomEntity>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
