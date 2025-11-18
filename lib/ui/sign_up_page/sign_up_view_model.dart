import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rice_chat/data/model/user_entity.dart';
import 'package:rice_chat/data/repository/storage_repository.dart';
import 'package:rice_chat/data/repository/user_repository.dart';
import 'package:rice_chat/ui/sign_up_page/sign_up_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_up_view_model.g.dart';

@riverpod
class SignUpViewModel extends _$SignUpViewModel {
  @override
  SignUpState build() => const SignUpState();

  /// 유효성 검증 로직
  String? validate({required String name, required String ageText, required String about}) {
    if (name.isEmpty) return "이름을 입력해주세요";
    if (ageText.isEmpty) return "나이를 입력해주세요";
    if (int.tryParse(ageText) == null) return "나이를 숫자로 입력해주세요";
    if (about.isEmpty) return "소개 멘트를 입력해주세요";
    return null;
  }

  /// 프로필 이미지 storage 업로드
  Future<void> pickAndUploadProfileImage() async {
    try {
      state = state.copyWith(isLoading: true);

      final picker = ImagePicker();
      final picked = await picker.pickImage(source: ImageSource.gallery);

      // 이미지 선택 안했을 경우
      if (picked == null) {
        state = state.copyWith(isLoading: false);
        return;
      }

      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) throw Exception("로그인 연결 오류.");

      final storage = ref.read(storageRepositoryProvider);
      final profileUrl = await storage.uploadProfileImage(picked, uid);

      state = state.copyWith(profileImgUrl: profileUrl, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// 파이어베이스 문서 갱신
  Future<void> saveProfile({
    required String name,
    required int age,
    required bool sex,
    required String? address,
    required String? aboutMe,
  }) async {
    final user = FirebaseAuth.instance.currentUser; // 나중에 authVM에서 상태 값으로 관리하도록 변경
    if (user == null) throw Exception("로그인 정보 없음");

    final repo = ref.read(userRepositoryProvider);

    final entity = UserEntity(
      id: user.uid,
      name: name,
      age: age,
      sex: sex,
      address: address,
      aboutMe: aboutMe,
      profileImgUrl: state.profileImgUrl,
    );
    await repo.updateUser(entity);
  }
}
