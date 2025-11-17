import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rice_chat/ui/post_write_page/post_write_view_model.dart';

class PhotoPickerRowView extends ConsumerWidget {
  /// 이미지 추가 수평 스크롤 위젯
  const PhotoPickerRowView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postWriteViewModelProvider);

    return SizedBox(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        // 선택한 이미지가 10장 이하일 경우 불러오기 버튼 포함
        itemCount: state.ableToAdd ? state.images.length + 1 : state.images.length,
        separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          // 첫번째 인덱스 (이미지 불러오기 버튼)
          if (index == 0 && state.ableToAdd) {
            return _AddPhotoView();
          }

          // 나머지 인덱스 (image_picker에서 고른 사진들)
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                // 썸네일
                SizedBox(
                  width: 60,
                  height: 60,
                  child: state.ableToAdd
                      ? Image.file(File(state.images[index - 1].path), fit: BoxFit.cover)
                      : Image.file(File(state.images[index].path), fit: BoxFit.cover),
                ),

                // 삭제 버튼
                Positioned(
                  top: 4,
                  right: 4,
                  child: InkWell(
                    onTap: () => {
                      state.ableToAdd
                          ? ref.read(postWriteViewModelProvider.notifier).removeImage(index - 1)
                          : ref.read(postWriteViewModelProvider.notifier).removeImage(index),
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(4),
                      child: const Icon(Icons.close, size: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _AddPhotoView extends ConsumerWidget {
  /// 이미지 추가 버튼
  const _AddPhotoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.read(postWriteViewModelProvider);
    return InkWell(
      onTap: state.ableToAdd
          ? () => {ref.read(postWriteViewModelProvider.notifier).pickImages()}
          : null,
      borderRadius: BorderRadius.circular(8),
      child: Ink(
        width: 60,
        height: 60,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Icon(
            Icons.camera_alt_rounded,
            size: 24,
            color: state.ableToAdd ? Colors.black45 : Colors.grey,
          ),
        ),
      ),
    );
  }
}
