import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'post_write_state.freezed.dart';

@freezed
abstract class PostWriteState with _$PostWriteState {
  // getter 쓰려면 이게 꼭 필요함
  const PostWriteState._();

  static const int maxCount = 10; // 사진 최대 선택 수

  const factory PostWriteState({
    @Default([]) List<XFile> images, // 선택한 이미지 리스트
    @Default('') String title,
    @Default([]) List<String> tags,
    @Default('') String content,
    @Default(false) bool loading, // 저장 중 로딩
  }) = _PostWriteState;

  bool get ableToAdd => images.length < maxCount;
  int get remain => maxCount - images.length;
}
