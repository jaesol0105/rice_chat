import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rice_chat/ui/post_write_page/post_write_view_model.dart';
import 'package:rice_chat/ui/post_write_page/widgets/photo_picker_row_view.dart';

class PostWriteView extends HookConsumerWidget {
  const PostWriteView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postWriteViewModelProvider);
    final vm = ref.read(postWriteViewModelProvider.notifier);

    final titleController = useTextEditingController();
    final contentController = useTextEditingController();

    return Column(
      children: [
        // 사진 등록
        titleLabel("사진 등록(${state.images.length}/10)"),
        SizedBox(height: 5),
        PhotoPickerRowView(),
        SizedBox(height: 30),

        // 게시글 제목
        titleLabel("제목"),
        SizedBox(height: 5),
        TextField(
          controller: titleController,
          onChanged: vm.updateTitle,
          maxLength: 30,
          maxLines: 1,
          //decoration: styleInputDecoration().copyWith(hintText: '글 제목을 입력하세요.'),
        ),
        SizedBox(height: 30),

        // 내용
        titleLabel("내용"),
        SizedBox(height: 5),
        TextField(
          controller: contentController,
          onChanged: vm.updateContent,
          maxLength: 1000,
          maxLines: 8,
          //decoration: styleInputDecoration().copyWith(hintText: '글 내용을 입력하세요.'),
        ),
        SizedBox(height: 30),
      ],
    );
  }

  // TextField 스타일 정의
  InputDecoration styleInputDecoration() {
    return InputDecoration(
      counterText: '',
      // 포커스가 없을 때 (기본) 테두리 색상
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 3),
        borderRadius: BorderRadius.circular(10.0),
      ),
      // 포커스가 있을 때 (선택되었을 때) 테두리 색상
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black, // 원하는 포커스 색상
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  // 인풋창 라벨 스타일 정의
  Widget titleLabel(String title) {
    return Align(alignment: Alignment.centerLeft, child: Text(title));
  }
}
