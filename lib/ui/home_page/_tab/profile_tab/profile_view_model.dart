import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rice_chat/data/model/user_entity.dart';
import 'package:rice_chat/data/repository/storage_repository.dart';
import 'package:rice_chat/data/repository/user_repository.dart';
import 'package:rice_chat/ui/home_page/_tab/profile_tab/profile_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_view_model.g.dart';

@riverpod
class ProfileViewModel extends _$ProfileViewModel{
  @override
  ProfileState build() => ProfileState();

  Future<void> loadProfile() async{
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final repo = ref.read(userRepositoryProvider);
    final user = await repo.getUser(uid);

    state = state.copyWith(
      user: user,
      profileImgUrl: user.profileImgUrl,
    );
  }

  Future<void> updateProfileImage() async{
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if(picked == null) return;

    final uid = FirebaseAuth.instance.currentUser?.uid;
    if(uid == null) return;

    final storage = ref.read(storageRepositoryProvider);
    final url = await storage.uploadProfileImage(picked, uid);

    state = state.copyWith(profileImgUrl: url);
  }

  Future<void> saveProfile({
    required String name,
    required int age,
    required bool sex,
    required String about,
  }) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final repo = ref.read(userRepositoryProvider);

    final updated = UserEntity(
      id: uid,
      name: name,
      age: age,
      sex: sex,
      aboutMe: about,
      address: state.user?.address,
      profileImgUrl: state.profileImgUrl ?? state.user?.profileImgUrl,
    );

    await repo.updateUser(updated);

    state = state.copyWith(user: updated);
  }
}