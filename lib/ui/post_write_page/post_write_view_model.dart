import 'package:rice_chat/data/model/post_entity.dart';
import 'package:rice_chat/data/repository/post_repository.dart';
import 'package:rice_chat/data/repository/storage_repository.dart';
import 'package:rice_chat/ui/post_write_page/post_write_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

part 'post_write_view_model.g.dart';

@riverpod
class PostWriteViewModel extends _$PostWriteViewModel {
  // 초기 상태
  @override
  PostWriteState build() {
    return const PostWriteState();
  }

  /// 업로드할 이미지 선택
  void pickImages() async {
    if (state.remain <= 0) return;

    // 사진 선택
    final picked = await ImagePicker().pickMultiImage(
      // limit: state.remain,
      imageQuality: 85,
      requestFullMetadata: false,
    );

    if (picked == null || picked.isEmpty) return;

    /* 남은 수만큼만 추가 (최대 10개 제한)
      (remain 동작안할 경우를 대비해서 수동으로 예외처리) */
    final addList = picked.take(state.remain);

    state = state.copyWith(images: [...state.images, ...addList]);
  }

  /// 선택한 이미지 삭제
  void removeImage(int index) {
    final newList = [...state.images]..removeAt(index);

    state = state.copyWith(images: newList);
  }

  /// 입력값 업데이트
  void updateTitle(String v) => state = state.copyWith(title: v);
  void updateContent(String v) => state = state.copyWith(content: v);

  /// 유효성 검증
  String? validate() {
    if (state.images.isEmpty) return '이미지를 등록해 주세요'; // TODO : 미등록도 가능하게 나중에 바꾸기
    if (state.title.isEmpty) return '제목을 입력해 주세요';
    if (state.content.isEmpty) return '내용을 입력해 주세요';
    return null;
  }

  /// 저장 로직
  Future<(bool success, String? error, dynamic data)> save() async {
    // 유효성 검사
    final error = validate();
    if (error != null) return (false, error, null);

    // 이미 로딩 중일 땐 또 호출하지 않기
    if (state.loading) return (false, null, null);

    // loading 상태
    state = state.copyWith(loading: true);

    try {
      // Storage 업로드
      final repo = ref.read(storageRepositoryProvider);
      final urls = await repo.uploadImages(state.images);

      // BookEntity 생성
      final data = PostEntity(
        id: const Uuid().v4(),
        title: state.title,
        content: state.content,
        writer: 'test',
        images: urls,
      );

      // Firestore 저장
      ref.read(postRepositoryProvider).createPost(post: data, address: '경기도 군포시 산본동');

      return (true, null, data);
    } catch (e) {
      return (false, '저장 중 오류가 발생했습니다.', null);
    } finally {
      state = state.copyWith(loading: false);
    }
  }
}
