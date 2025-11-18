import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rice_chat/data/model/chat_entity.dart';
import 'package:rice_chat/ui/chat_page/chat_card.dart';
import 'package:rice_chat/ui/chat_page/chat_view_model.dart';
import 'package:rice_chat/ui/user_global_view_model.dart';

class ChatPage extends HookConsumerWidget {
  const ChatPage(this.roomId, {super.key});

  final String roomId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ---------- 유저 상태 처리 ----------
    final userAsync = ref.watch(userGlobalViewModelProvider);

    if (userAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (userAsync.hasError) {
      return const Scaffold(body: Center(child: Text('유저 정보를 불러오지 못했습니다.')));
    }

    final user = userAsync.value;
    if (user == null) {
      return const Scaffold(body: Center(child: Text('유저 정보가 없습니다. 다시 로그인 해주세요.')));
    }

    // ---------- 훅 / 컨트롤러 ----------
    final bottomSheetHeight = useState<double>(0);
    final messageController = useTextEditingController();
    final scrollController = useScrollController();

    final lastSendTime = useState<DateTime>(DateTime(0));
    final lastSendIsMine = useState<bool>(false);
    final lastSenderId = useState<String>('');

    final bottomSheetKey = useMemoized(() => GlobalKey());

    void updateBottomSheetHeight() {
      final bottomSheetContext = bottomSheetKey.currentContext;
      if (bottomSheetContext != null) {
        final renderBox = bottomSheetContext.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          bottomSheetHeight.value = renderBox.size.height;
        }
      }
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        updateBottomSheetHeight();
      });
      return null;
    }, const []);

    // ---------- ViewModel / 상태 ----------
    final chatVm = ref.read(chatViewModelProvider(roomId).notifier);
    final chats = ref.watch(chatViewModelProvider(roomId));

    // 새 메시지 오면 아래로 스크롤
    ref.listen<List<ChatEntity>>(chatViewModelProvider(roomId), (previous, next) {
      if (previous == null || next.length > previous.length) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scrollController.hasClients) {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          }
        });
      }
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: const Color(0xFFF8F4E8),
          centerTitle: true,
          title: Text(roomId, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: ListView.builder(
          padding: EdgeInsets.fromLTRB(12, 20, 12, bottomSheetHeight.value + 10),
          controller: scrollController,
          itemCount: chats.length,
          itemBuilder: (context, index) {
            final currentChat = chats[index];
            final currentSenderId = currentChat.senderId;
            final currentMessageTime = currentChat.createdAt; // DateTime?

            // 기본값
            DateTime? displayTime = currentMessageTime;
            bool showProfile = true;

            // 위쪽(이전) 메시지와 비교해서 프로필 묶기
            if (index > 0) {
              final prevChat = chats[index - 1];
              final prevSenderId = prevChat.senderId;
              final prevTime = prevChat.createdAt;

              if (currentSenderId == prevSenderId &&
                  currentMessageTime != null &&
                  prevTime != null) {
                final diff = currentMessageTime.difference(prevTime);
                // 예시: 1분 이내면 프로필 숨기기
                if (diff.inMinutes < 1) {
                  showProfile = false;
                }
              }
            }

            // 아래쪽(다음) 메시지와 비교해서 시간 생략 여부
            if (index < chats.length - 1) {
              final nextChat = chats[index + 1];
              final nextSenderId = nextChat.senderId;
              final nextTime = nextChat.createdAt;

              if (currentSenderId == nextSenderId &&
                  currentMessageTime != null &&
                  nextTime != null) {
                final diff = nextTime.difference(currentMessageTime);
                if (diff.inMinutes < 1) {
                  // 너무 가까운 시간 -> 이 메시지에는 시간 표시 안 함
                  displayTime = null;
                }
              }
            }

            return Column(
              children: [
                ChatCard(
                  id: currentChat.id,
                  senderId: currentChat.senderId,
                  senderName: currentChat.sender,
                  message: currentChat.message,
                  time: displayTime, // ✅ DateTime? 로 넘김
                  imageUrl: currentChat.imageUrl,
                  isMine: user.id == currentChat.senderId,
                  showProfile: showProfile,
                ),
                const SizedBox(height: 8),
              ],
            );
          },
        ),
        bottomSheet: SafeArea(
          key: bottomSheetKey,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(width: 1, color: Colors.grey[300]!)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    maxLines: 4,
                    minLines: 1,
                    controller: messageController,
                    onChanged: (_) {
                      updateBottomSheetHeight();
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: Colors.grey[500]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(width: 2, color: Color(0xff4CAF50)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () async {
                    final text = messageController.text.trim();
                    if (text.isEmpty) return;

                    await chatVm.sendMessage(
                      ChatEntity(
                        id: '',
                        createdAt: DateTime.now(),
                        message: text,
                        imageUrl: user.profileImgUrl ?? '',
                        sender: user.name,
                        senderId: user.id,
                      ),
                    );

                    messageController.clear();
                    lastSendTime.value = DateTime.now();
                    lastSendIsMine.value = true;
                    lastSenderId.value = user.id;

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (scrollController.hasClients) {
                        scrollController.jumpTo(scrollController.position.maxScrollExtent);
                      }
                    });
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
