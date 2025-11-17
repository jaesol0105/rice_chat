import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rice_chat/ui/post_write_page/post_write_view_model.dart';
import 'package:rice_chat/ui/post_write_page/widgets/post_write_view.dart';

class PostWritePage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("글 쓰기"),
        ),

        // 글 작성 뷰
        body: Scrollbar(
          thumbVisibility: false,
          trackVisibility: false,
          interactive: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: PostWriteView(),
            ),
          ),
        ),

        // 저장 버튼
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 30),
          child: ElevatedButton(
            onPressed: () async {
              // $1 success, $2 msg, $3 entity
              final result = await ref.read(postWriteViewModelProvider.notifier).save();
              if (!result.$1) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(result.$2!))); // 실패
                return;
              }
              Navigator.pop(context, result.$3); // 성공
            },
            child: const Text('저장'),
          ),
        ),
      ),
    );
  }
}
