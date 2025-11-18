import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rice_chat/ui/home_page/widgets/home_bottom_navigation_bar.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = "미스터 옥";
    final userAgeGender = "29세, 남성";
    final userDescription = """
나는야 박력있는 남자
안녕하세요, 박력있는 남자 김옥윤입니다.
제가 제일 좋아하는 음식은 된장 술밥,
그리고 참치 김치찌개입니다.
오늘 하루 나의 외로움을 달래줄
밥 친구 찾습니다
또 춤도 좋아합니다!
지금까지 전적을 말씀드리자면
강호동의 술배틀에서
100잔 중 99배 1승을 달성한 전적이 있습니다
저 술 잘 먹는 박력있는 남자니깐
많은 관심 부탁드립니다
많관부! 나는야 박력있는 남자~
""";

    final profileImage = useState<File?>(null);

    final nameController = useTextEditingController(text: userName);
    final ageController = useTextEditingController(text: userAgeGender);
    final descController = useTextEditingController(text: userDescription);

    Future<void> pickImage() async {
      final picker = ImagePicker();
      final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
      if (picked != null) {
        profileImage.value = File(picked.path);
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            children: [
              InkWell(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: profileImage.value != null
                      ? FileImage(profileImage.value!)
                      : null,
                  child: profileImage.value == null
                      ? const Icon(Icons.camera_alt, size: 38, color: Colors.black54)
                      : null,
                ),
              ),

              const SizedBox(height: 40),

              // 이름
              _buildInputField(context: context, controller: nameController, hint: "이름"),

              const SizedBox(height: 20),

              _buildInputField(context: context, controller: ageController, hint: "나이/성별"),

              const SizedBox(height: 20),

              _buildInputField(
                context: context,
                controller: descController,
                hint: "소개 멘트",
                maxLines: 15,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: HomeBottomNavigationBar(),
    );
  }

  Widget _buildInputField({
    required BuildContext context,
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(hintText: hint),
    );
  }
}
